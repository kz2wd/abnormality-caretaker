extends Node3D

const MB_1 = preload("res://scenes/abnormalities/abnormality_002/assets/sounds/mb1.wav")
const MB_2 = preload("res://scenes/abnormalities/abnormality_002/assets/sounds/mb2.wav")
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D


var play_amount = 0
func _process(delta: float) -> void:
	if !audio_player.is_playing():
		if randi_range(0, 100) < play_amount:
			audio_player.stream = MB_2
		else:
			audio_player.stream = MB_1
		audio_player.play()
		play_amount += 1
