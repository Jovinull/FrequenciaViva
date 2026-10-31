class_name AudioDirector
extends Node

const DIAL_CLICK := preload("res://assets/audio/dial_click.wav")
const RADIO_HISS := preload("res://assets/audio/radio_hiss.wav")
const SIGNAL_LOCK := preload("res://assets/audio/signal_lock.wav")
const TRANSMISSION_COMPLETE := preload("res://assets/audio/transmission_complete.wav")

var _click_player: AudioStreamPlayer
var _hiss_player: AudioStreamPlayer
var _lock_player: AudioStreamPlayer
var _transmission_player: AudioStreamPlayer


func _ready() -> void:
	_click_player = AudioStreamPlayer.new()
	_click_player.bus = "Master"
	_click_player.volume_db = -9.0
	_click_player.stream = DIAL_CLICK
	add_child(_click_player)

	_hiss_player = AudioStreamPlayer.new()
	_hiss_player.bus = "Master"
	_hiss_player.volume_db = -25.0
	_hiss_player.stream = RADIO_HISS
	add_child(_hiss_player)

	_lock_player = AudioStreamPlayer.new()
	_lock_player.bus = "Master"
	_lock_player.volume_db = -3.0
	_lock_player.stream = SIGNAL_LOCK
	add_child(_lock_player)

	_transmission_player = AudioStreamPlayer.new()
	_transmission_player.bus = "Master"
	_transmission_player.volume_db = -3.0
	_transmission_player.stream = TRANSMISSION_COMPLETE
	add_child(_transmission_player)


func play_dial_click() -> void:
	if _click_player.playing:
		return
	_click_player.play()


func play_tuning_hiss() -> void:
	if _hiss_player.playing:
		return
	_hiss_player.play()


func play_signal_lock() -> void:
	_lock_player.play()


func play_transmission_complete() -> void:
	_transmission_player.play()
