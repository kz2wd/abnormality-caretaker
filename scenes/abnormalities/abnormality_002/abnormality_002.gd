extends Item
class_name Abnormality002

const MB_1 = preload("res://scenes/abnormalities/abnormality_002/assets/sounds/mb1.wav")
const MB_2 = preload("res://scenes/abnormalities/abnormality_002/assets/sounds/mb2.wav")
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

@export var abno4: Abnormality004

func _ready() -> void:
	in_hand_rotation = Vector3(0, - PI / 2, 0)
	

var play_amount = 0
var is_on = false
func _process(delta: float) -> void:
	handle_play_music()
	handle_roll(delta)
	handle_open(delta)
	super._process(delta)

var has_been_picked = false
func interact(player: Player) -> void:
	if !has_been_picked:
		has_been_picked = true
		is_on = true
		if abno4 != null:
			abno4.alert()
	super.interact(player)


func handle_play_music():
	if is_on and !audio_player.is_playing():
		if randi_range(0, 100) < play_amount:
			audio_player.stream = MB_2
		else:
			audio_player.stream = MB_1
		audio_player.play()
		play_amount += 1

@onready var platform: Node3D = $base2/platform
@onready var key: Node3D = $base2/key2
@export var platform_rotation_speed = 1.5
@export var key_rotation_speed = 0.3
func handle_roll(delta):
	if !is_on:
		return
	platform.rotate(Vector3.UP, delta * platform_rotation_speed)
	key.rotate(Vector3.FORWARD, delta * key_rotation_speed)
	

@onready var top: Node3D = $base2/top

@export var open_lid_angle: float = 135.0
@export var opening_speed: float = 1.0
func handle_open(delta: float):
	if !is_on:
		return
	top.rotation_degrees.z = lerp(top.rotation_degrees.z, open_lid_angle, opening_speed * delta)
