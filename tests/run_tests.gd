extends SceneTree

const FrequencyPuzzle = preload("res://scripts/frequency_puzzle.gd")
const SignalRoutePuzzle = preload("res://scripts/signal_route_puzzle.gd")
const CampaignState = preload("res://scripts/campaign_state.gd")
var _failures := 0


func _init() -> void:
	_test_frequency_bounds_and_lock()
	_test_ten_bar_readout()
	_test_deterministic_route_solution()
	_test_campaign_transitions_and_restart()
	if _failures == 0:
		print("PASS: 4 grupos de testes da fatia")
		quit(0)
	else:
		push_error("FAIL: %d verificações falharam" % _failures)
		quit(1)


func _read_json(path: String) -> Dictionary:
	var value: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	_check(value is Dictionary, "JSON inválido: " + path)
	if not value is Dictionary:
		return {}
	return value


func _check(condition: bool, message: String) -> void:
	if not condition:
		_failures += 1
		push_error(message)


func _test_frequency_bounds_and_lock() -> void:
	var puzzle := FrequencyPuzzle.new(_read_json("res://data/pilot_puzzle.json"))
	_check(is_equal_approx(puzzle.clamp_frequency(-100.0), 92.0), "limite inferior da frequência")
	_check(is_equal_approx(puzzle.clamp_frequency(400.0), 104.0), "limite superior da frequência")
	_check(is_equal_approx(puzzle.snap_frequency(99.24), 99.2), "passo de 0,1 MHz")
	_check(puzzle.can_transmit(99.2), "frequência central deve travar")
	_check(puzzle.can_transmit(99.1), "limite de sintonia válido")
	_check(not puzzle.can_transmit(99.0), "fora da tolerância não pode transmitir")
	_check(not puzzle.can_transmit(95.4), "pico falso não pode transmitir")
	print("PASS: limites, quantização e trava de frequência")


func _test_ten_bar_readout() -> void:
	var puzzle := FrequencyPuzzle.new(_read_json("res://data/pilot_puzzle.json"))
	_check(puzzle.bar_count_at(99.2) == 10, "o pico correto deve mostrar 10/10")
	_check(puzzle.bar_count_at(95.4) == 7, "o pico falso deve mostrar 7/10")
	_check(puzzle.bar_count_at(92.0) == 0, "o limite distante deve mostrar 0/10")
	_check(puzzle.bar_count_at(92.0) >= 0 and puzzle.bar_count_at(92.0) <= 10, "medidor fora dos limites")
	print("PASS: dez segmentos correspondem a dez níveis")


func _test_deterministic_route_solution() -> void:
	var puzzle := SignalRoutePuzzle.new(_read_json("res://data/pilot_routes.json"))
	_check(puzzle.remaining_bars("short_busy") == 5, "rota curta combina alcance e canal ocupado")
	_check(puzzle.remaining_bars("balanced_clear") == 7, "rota equilibrada chega no mínimo")
	_check(puzzle.remaining_bars("long_clear") == 6, "rota longa ainda perde alcance")
	_check(puzzle.valid_route_ids() == ["balanced_clear"], "a solução deve ser única e determinística")
	_check(not puzzle.can_transmit("unknown"), "retransmissor desconhecido deve ser inválido")
	_check(not puzzle.can_transmit("short_busy"), "rota com interferência não deve transmitir")
	_check(puzzle.can_transmit("balanced_clear"), "rota equilibrada deve transmitir")
	print("PASS: solução única do puzzle de roteamento")


func _test_campaign_transitions_and_restart() -> void:
	var state := CampaignState.new()
	_check(not state.begin_successful_transmission(), "não transmite antes do início")
	state.begin()
	_check(state.phase == CampaignState.Phase.TUNING, "início abre tutorial de sintonia")
	state.record_transmission_attempt()
	_check(state.attempts == 1, "tentativa registrada")
	_check(state.begin_successful_transmission(), "sintonia permite transmitir")
	state.receive_message()
	_check(state.open_route_puzzle(), "confirmação abre o roteamento")
	_check(state.phase == CampaignState.Phase.ROUTING, "fase de rota ativa")
	state.record_transmission_attempt()
	_check(state.begin_successful_transmission(), "rota válida permite transmitir")
	state.receive_message()
	_check(not state.open_route_puzzle(), "entrega final não deve reabrir o tutorial de rota")
	state.restart()
	_check(state.phase == CampaignState.Phase.BRIEFING, "reinício volta ao começo")
	_check(state.stage == CampaignState.Stage.TUNING, "reinício seleciona sintonia")
	_check(state.attempts == 0, "reinício limpa tentativas")
	print("PASS: estados, avanço e reinício da campanha")
