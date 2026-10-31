class_name CampaignState
extends RefCounted

enum Phase { BRIEFING, TUNING, TRANSMITTING, RECEIVED }

var phase: Phase = Phase.BRIEFING
var attempts := 0


func begin() -> void:
	if phase == Phase.BRIEFING:
		phase = Phase.TUNING


func record_transmission_attempt() -> void:
	if phase == Phase.TUNING:
		attempts += 1


func begin_successful_transmission() -> bool:
	if phase != Phase.TUNING:
		return false
	phase = Phase.TRANSMITTING
	return true


func receive_message() -> void:
	if phase == Phase.TRANSMITTING:
		phase = Phase.RECEIVED


func restart() -> void:
	phase = Phase.BRIEFING
	attempts = 0
