extends Node3D
class_name Abnormality004

@onready var animation_player: AnimationPlayer = $walking_cubes/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if !animation_player.is_playing():
		#animation_player.play("run")


const ALERTED = preload("res://scenes/abnormalities/abnormality_004/alerted.wav")
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
func alert():
	audio_stream_player_3d.stream = ALERTED
	audio_stream_player_3d.play()
	self.visible = false
