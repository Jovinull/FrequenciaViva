class_name CampaignState
extends RefCounted

enum Phase { BRIEFING, TUNING, TRANSMITTING, RECEIVED, ROUTING }
enum Stage { TUNING, ROUTING }

var phase: Phase = Phase.BRIEFING
var stage: Stage = Stage.TUNING
var attempts := 0


func begin() -> void:
	if phase == Phase.BRIEFING:
		stage = Stage.TUNING
		phase = Phase.TUNING


func record_transmission_attempt() -> void:
	if phase == Phase.TUNING or phase == Phase.ROUTING:
		attempts += 1


func begin_successful_transmission() -> bool:
	if phase != Phase.TUNING and phase != Phase.ROUTING:
		return false
	phase = Phase.TRANSMITTING
	return true


func receive_message() -> void:
	if phase == Phase.TRANSMITTING:
		phase = Phase.RECEIVED


func open_route_puzzle() -> bool:
	if phase != Phase.RECEIVED or stage != Stage.TUNING:
		return false
	stage = Stage.ROUTING
	phase = Phase.ROUTING
	return true


func restart() -> void:
	phase = Phase.BRIEFING
	stage = Stage.TUNING
	attempts = 0
