extends Control

const PUZZLE_SPEC_PATH := "res://data/pilot_puzzle.json"
const MESSAGE_PATH := "res://data/radio_messages.json"
const COLOR_CREAM := Color("#F3DBA5")
const COLOR_MUTED := Color("#A5B4A6")
const COLOR_TURQUOISE := Color("#64BBA6")
const COLOR_CORAL := Color("#D66D65")
const COLOR_AMBER := Color("#E2B36B")
const COLOR_UNLIT := Color("#3F3F74")

@onready var dial: TunerDial = $Dial
@onready var frequency_label: Label = $FrequencyLabel
@onready var status_label: Label = $StatusLabel
@onready var message_label: Label = $MessageLabel
@onready var hint_label: Label = $HintLabel
@onready var meter_label: Label = $MeterLabel
@onready var transmit_button: Button = $TransmitButton
@onready var audio: AudioDirector = $AudioDirector
@onready var wave_line: SignalWave = $SignalWave

var _puzzle: FrequencyPuzzle
var _campaign := CampaignState.new()
var _message: Dictionary
var _signal_lights: Array[ColorRect] = []
var _last_bar_count := -1
var _last_quality := -1.0
var _shown_lock := false
var _button_last_played := 0.0
var _attempt_feedback := false


func _ready() -> void:
	var puzzle_spec: Dictionary = _load_json(PUZZLE_SPEC_PATH)
	var all_messages: Dictionary = _load_json(MESSAGE_PATH)
	_puzzle = FrequencyPuzzle.new(puzzle_spec)
	_message = all_messages.get(str(puzzle_spec.get("message_id", "workshop_bulletin")), {})

	var lights := $SignalLights
	for child in lights.get_children():
		if child is ColorRect:
			_signal_lights.append(child)

	dial.minimum_frequency = float(puzzle_spec.frequency_min)
	dial.maximum_frequency = float(puzzle_spec.frequency_max)
	dial.step = float(puzzle_spec.frequency_step)
	dial.frequency_changed.connect(_on_frequency_changed)
	transmit_button.pressed.connect(_on_transmit_pressed)
	transmit_button.add_theme_font_size_override("font_size", 9)
	transmit_button.add_theme_color_override("font_color", Color("#F3DBA5"))
	transmit_button.add_theme_color_override("font_hover_color", Color("#FFF0C6"))
	transmit_button.add_theme_color_override("font_pressed_color", Color("#161F2A"))
	transmit_button.add_theme_stylebox_override("normal", _button_style(Color("#36525A"), Color("#66766A")))
	transmit_button.add_theme_stylebox_override("hover", _button_style(Color("#52675B"), Color("#E2B36B")))
	transmit_button.add_theme_stylebox_override("pressed", _button_style(Color("#E2B36B"), Color("#F3DBA5")))
	transmit_button.add_theme_stylebox_override("disabled", _button_style(Color("#263640"), Color("#52675B")))

	$TitleLabel.add_theme_font_size_override("font_size", 15)
	$TitleLabel.add_theme_color_override("font_color", COLOR_CREAM)
	status_label.add_theme_font_size_override("font_size", 10)
	status_label.add_theme_color_override("font_color", COLOR_MUTED)
	frequency_label.add_theme_font_size_override("font_size", 12)
	frequency_label.add_theme_color_override("font_color", Color("#E2B36B"))
	message_label.add_theme_font_size_override("font_size", 10)
	message_label.add_theme_color_override("font_color", COLOR_CREAM)
	hint_label.add_theme_font_size_override("font_size", 8)
	hint_label.add_theme_color_override("font_color", COLOR_MUTED)
	meter_label.add_theme_font_size_override("font_size", 8)
	meter_label.add_theme_color_override("font_color", COLOR_CREAM)
	$FictionLabel.add_theme_font_size_override("font_size", 7)
	$FictionLabel.add_theme_color_override("font_color", Color("#A5B4A6"))

	dial.set_frequency(float(puzzle_spec.starting_frequency), false)
	dial.grab_focus()
	_campaign.begin()
	message_label.text = str(_message.get("briefing", "A equipe preparou um boletim. Procure o sinal mais forte."))
	hint_label.text = str(_message.get("hint", "Ajuste até quatro barras. Então transmita."))
	frequency_label.text = _format_frequency(dial.frequency)
	status_label.text = "ESTAÇÃO 01   ·   SINTONIZANDO"
	transmit_button.text = "TRANSMITIR"
	_update_signal_readout()


func _load_json(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		push_error("Arquivo de conteúdo ausente: " + path)
		return {}
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	if not parsed is Dictionary:
		push_error("JSON inválido: " + path)
		return {}
	return parsed


func _button_style(fill: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.set_border_width_all(2)
	style.set_content_margin_all(2)
	return style


func _format_frequency(value: float) -> String:
	return "%05.1f MHz" % value


func _on_frequency_changed(value: float) -> void:
	if _campaign.phase == CampaignState.Phase.TRANSMITTING or _campaign.phase == CampaignState.Phase.RECEIVED:
		return
	if _attempt_feedback:
		message_label.text = str(_message.get("briefing", "A equipe preparou um boletim. Procure o sinal mais forte."))
		_attempt_feedback = false
	if _campaign.phase == CampaignState.Phase.BRIEFING:
		_campaign.begin()
		transmit_button.text = "TRANSMITIR"
		status_label.text = "ESTAÇÃO 01   ·   BUSCANDO SINAL"
	frequency_label.text = _format_frequency(value)
	var quality := _puzzle.quality_at(value)
	var bars := _puzzle.bar_count_at(value)
	if bars != _last_bar_count:
		audio.play_tuning_hiss()
	if bars != _last_bar_count or absf(quality - _last_quality) > 0.07:
		var now := Time.get_ticks_msec() / 1000.0
		if now - _button_last_played >= 0.07:
			audio.play_dial_click()
			_button_last_played = now
	_last_bar_count = bars
	_last_quality = quality
	_update_signal_readout()
	var locked := _puzzle.can_transmit(value)
	if locked and not _shown_lock:
		audio.play_signal_lock()
		status_label.text = "SINAL ESTÁVEL   ·   PRONTO PARA ENVIAR"
	elif not locked:
		status_label.text = "ESTAÇÃO 01   ·   BUSCANDO SINAL"
	_shown_lock = locked


func _update_signal_readout() -> void:
	if _signal_lights.is_empty() or _puzzle == null:
		return
	var quality := _puzzle.quality_at(dial.frequency)
	var bars := _puzzle.bar_count_at(dial.frequency)
	var active_segments := clampi(roundi(quality * float(_signal_lights.size())), 0, _signal_lights.size())
	var active_color := COLOR_CORAL
	if quality >= 0.5:
		active_color = COLOR_AMBER
	if _puzzle.can_transmit(dial.frequency):
		active_color = COLOR_TURQUOISE
	for index in range(_signal_lights.size()):
		var light := _signal_lights[index]
		light.color = active_color if index < active_segments else COLOR_UNLIT
		light.visible = index < active_segments

	if _campaign.phase == CampaignState.Phase.RECEIVED:
		meter_label.text = "MENSAGEM RECEBIDA"
	elif _puzzle.can_transmit(dial.frequency):
		meter_label.text = "SINAL ESTÁVEL"
	else:
		meter_label.text = "SINAL   %d / 4" % bars


func _on_transmit_pressed() -> void:
	match _campaign.phase:
		CampaignState.Phase.BRIEFING:
			_campaign.begin()
			status_label.text = "ESTAÇÃO 01   ·   BUSCANDO SINAL"
			transmit_button.text = "TRANSMITIR"
			message_label.text = "O boletim está pronto. A oficina aguarda a chamada da equipe."
			return
		CampaignState.Phase.TUNING:
			_campaign.record_transmission_attempt()
			if not _puzzle.can_transmit(dial.frequency):
				_attempt_feedback = true
				status_label.text = "AINDA NÃO   ·   PROCURE O PICO MAIS FORTE"
				message_label.text = "O sinal veio cortado. Tente de novo."
				dial.grab_focus()
				return
			if not _campaign.begin_successful_transmission():
				return
			transmit_button.disabled = true
			transmit_button.text = "ENVIANDO..."
			hint_label.visible = false
			meter_label.text = "TRANSMITINDO"
			status_label.text = "PORTADORA CONFIRMADA   ·   ENVIANDO BOLETIM"
			audio.play_transmission_complete()
			wave_line.play()
			var flash := create_tween()
			flash.tween_property($RadioBody, "modulate", Color(1.0, 1.14, 1.06), 0.12)
			flash.tween_property($RadioBody, "modulate", Color.WHITE, 0.35)
			await get_tree().create_timer(0.62).timeout
			_campaign.receive_message()
			status_label.text = "MENSAGEM RECEBIDA   ·   ESTAÇÃO 01"
			message_label.text = str(_message.get("received", "A mensagem chegou ao destino."))
			meter_label.text = "MENSAGEM RECEBIDA"
			transmit_button.disabled = false
			transmit_button.text = "SINTONIZAR DE NOVO"
			_update_signal_readout()
		CampaignState.Phase.TRANSMITTING, CampaignState.Phase.RECEIVED:
			if _campaign.phase == CampaignState.Phase.RECEIVED:
				_restart()


func _restart() -> void:
	_campaign.restart()
	hint_label.visible = true
	hint_label.text = str(_message.get("hint", "Ajuste até quatro barras. Então transmita."))
	message_label.text = str(_message.get("briefing", "A equipe preparou um boletim. Procure o sinal mais forte."))
	status_label.text = "ESTAÇÃO 01   ·   SINTONIZANDO"
	transmit_button.text = "TRANSMITIR"
	dial.set_frequency(float(_puzzle.spec.starting_frequency), false)
	dial.grab_focus()
	_campaign.begin()
	frequency_label.text = _format_frequency(dial.frequency)
	_last_bar_count = -1
	_last_quality = -1.0
	_shown_lock = false
	_update_signal_readout()
