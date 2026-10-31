class_name FrequencyPuzzle
extends RefCounted

var spec: Dictionary


func _init(puzzle_spec: Dictionary) -> void:
	spec = puzzle_spec.duplicate(true)


func clamp_frequency(frequency: float) -> float:
	return clampf(frequency, float(spec.frequency_min), float(spec.frequency_max))


func snap_frequency(frequency: float) -> float:
	var step := float(spec.frequency_step)
	return snappedf(clamp_frequency(frequency), step)


func quality_at(frequency: float) -> float:
	var primary_distance := absf(frequency - float(spec.target_frequency))
	var primary_radius := float(spec.target_radius)
	var primary := exp(-pow(primary_distance / primary_radius, 2.0))

	var false_distance := absf(frequency - float(spec.false_peak_frequency))
	var false_radius := float(spec.false_peak_radius)
	var false_peak := float(spec.false_peak_strength) * exp(-pow(false_distance / false_radius, 2.0))
	return clampf(maxf(primary, false_peak), 0.0, 1.0)


func bar_count_at(frequency: float) -> int:
	if can_transmit(frequency):
		return 4
	return mini(4, floori(quality_at(frequency) * 4.0 + 0.12))


func can_transmit(frequency: float) -> bool:
	return absf(frequency - float(spec.target_frequency)) <= float(spec.lock_tolerance)
