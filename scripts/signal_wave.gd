class_name SignalWave
extends Node2D

var progress := 0.0:
	set(value):
		progress = clampf(value, 0.0, 1.0)
		queue_redraw()


func play() -> void:
	progress = 0.0
	visible = true
	var tween := create_tween()
	tween.tween_property(self, "progress", 1.0, 0.55).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void: visible = false)


func _draw() -> void:
	if progress <= 0.0:
		return
	var full_path := PackedVector2Array()
	for point_index in range(25):
		var ratio := float(point_index) / 24.0
		var x := ratio * 212.0
		var envelope := minf(1.0, ratio * 8.0) * (1.0 - ratio * 0.22)
		var y := sin(ratio * TAU * 6.0) * 3.0 * envelope
		full_path.append(Vector2(x, y))
	var drawn_points := int(ceili(float(full_path.size() - 1) * progress)) + 1
	var visible_path := PackedVector2Array()
	for point_index in range(mini(drawn_points, full_path.size())):
		visible_path.append(full_path[point_index])
	if visible_path.size() >= 2:
		draw_polyline(visible_path, Color("#64BBA6"), 2.0, false)
		draw_polyline(visible_path + PackedVector2Array([visible_path[-1] + Vector2(0, 1)]), Color("#F3DBA5"), 1.0, false)
