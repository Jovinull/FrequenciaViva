class_name TunerDial
extends TextureRect

signal frequency_changed(value: float)

@export var minimum_frequency := 92.0
@export var maximum_frequency := 104.0
@export var step := 0.1
@export var sweep_degrees := 300.0

var frequency := 93.8
var _dragging := false


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	focus_mode = Control.FOCUS_ALL
	pivot_offset = size * 0.5
	_update_rotation()


func set_frequency(value: float, notify := true) -> void:
	var next := snappedf(clampf(value, minimum_frequency, maximum_frequency), step)
	if is_equal_approx(next, frequency):
		return
	frequency = next
	_update_rotation()
	if notify:
		frequency_changed.emit(frequency)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index == MOUSE_BUTTON_LEFT:
			if mouse_button.pressed:
				_dragging = true
				grab_focus()
				accept_event()
			else:
				_dragging = false
				accept_event()
		elif mouse_button.pressed and mouse_button.button_index == MOUSE_BUTTON_WHEEL_UP:
			set_frequency(frequency + step)
			accept_event()
		elif mouse_button.pressed and mouse_button.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			set_frequency(frequency - step)
			accept_event()
	elif event is InputEventMouseMotion and _dragging:
		var mouse_motion := event as InputEventMouseMotion
		var frequency_per_screen_pixel := (maximum_frequency - minimum_frequency) / 160.0
		set_frequency(frequency + mouse_motion.screen_relative.x * frequency_per_screen_pixel)
		accept_event()
	elif event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_LEFT or event.keycode == KEY_DOWN:
			set_frequency(frequency - step)
			accept_event()
		elif event.keycode == KEY_RIGHT or event.keycode == KEY_UP:
			set_frequency(frequency + step)
			accept_event()
func _update_rotation() -> void:
	var amount := inverse_lerp(minimum_frequency, maximum_frequency, frequency)
	rotation = deg_to_rad(lerpf(-sweep_degrees * 0.5, sweep_degrees * 0.5, amount))
