class_name SignalRoutePuzzle
extends RefCounted

var spec: Dictionary


func _init(route_spec: Dictionary) -> void:
	spec = route_spec.duplicate(true)


func remaining_bars(route_id: String) -> int:
	var route: Dictionary = _route(route_id)
	if route.is_empty():
		return 0
	var incoming := int(spec.get("incoming_bars", 10))
	var total_loss := int(route.get("distance_loss", 0)) + int(route.get("interference_loss", 0))
	return clampi(incoming - total_loss, 0, 10)


func can_transmit(route_id: String) -> bool:
	if route_id.is_empty():
		return false
	return remaining_bars(route_id) >= int(spec.get("minimum_arrival_bars", 7))


func valid_route_ids() -> Array[String]:
	var result: Array[String] = []
	for route: Dictionary in spec.get("routes", []):
		var route_id := str(route.get("id", ""))
		if can_transmit(route_id):
			result.append(route_id)
	return result


func route_by_id(route_id: String) -> Dictionary:
	return _route(route_id).duplicate(true)


func _route(route_id: String) -> Dictionary:
	for route: Dictionary in spec.get("routes", []):
		if str(route.get("id", "")) == route_id:
			return route
	return {}
