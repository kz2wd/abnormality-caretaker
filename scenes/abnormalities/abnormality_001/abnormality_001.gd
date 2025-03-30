extends Node3D
class_name Abnormality001

@onready var heart_animator: AnimationPlayer = $heart2/AnimationPlayer

@onready var tentacle_animators: Array[AnimationPlayer] = [
	$trunk/tentacle2/AnimationPlayer,
	$trunk/tentacle3/AnimationPlayer,
	$trunk/tentacle4/AnimationPlayer,
]

const breath_in: Resource = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/br1_in.wav")
const breath_out: Resource = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/br1_out.wav")
const HB_1 = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/hb1.wav")

@onready var breath_sound_player: AudioStreamPlayer3D = $breather
@onready var heart_beat: AudioStreamPlayer3D = $heart_beat

enum BREATH {
	IN,
	OUT
}

# first played pattern is the opposite of the one put here
var current_breath_pattern = BREATH.OUT

@onready var mouth_breathers: Array[AnimationPlayer] = [
	$mouth_breath_1/AnimationPlayer,
	$mouth_breath_2/AnimationPlayer,
]

@onready var mouth_animator: AnimationPlayer = $mouth/AnimationPlayer
@onready var mouth_sound: AudioStreamPlayer3D = $mouth_sound
const MUNCHING = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/munching.wav")


func play_breath_in() -> void:
	current_breath_pattern = BREATH.IN
	breath_sound_player.stream = breath_in
	breath_sound_player.play()
	for tentacle in tentacle_animators:
		tentacle.play("idle_out")  # I prefer it inverted
	for breather in mouth_breathers:
		breather.play("mouth_idle_in")
	
func play_breath_out() -> void:
	current_breath_pattern = BREATH.OUT
	breath_sound_player.stream = breath_out
	breath_sound_player.play()
	for tentacle in tentacle_animators:
		tentacle.play("idle_in")  # I prefer it inverted
	for breather in mouth_breathers:
		breather.play("mouth_idle_out")

func handle_breath() -> void:
	# If no breathing is occuring (based on sound player), then trigger the next one
	if !breath_sound_player.is_playing():
		if current_breath_pattern == BREATH.IN:
			play_breath_out()
		else:
			play_breath_in()

func handle_heart() -> void:
	if !heart_beat.is_playing():
		heart_beat.stream = HB_1
		# make is last 1.1 sec and not 1 sec to avoid it finishing sooner than
		# the animation.
		heart_beat.play(0.9)  # File is 2 secs long, could find how to cut it in half simply so ...
		heart_animator.play("heart_idle")


func handle_mouth() -> void:
	if !mouth_animator.is_playing() and !mouth_sound.is_playing():
		mouth_animator.play("mouth_idle")
	if Input.is_action_just_pressed("test_circle_animations"):
		mouth_animator.play("mouth_chewing", 1, 0.8)
		mouth_sound.stream = MUNCHING
		mouth_sound.play(0.4)

func _process(_delta: float) -> void:
	handle_breath()
	handle_heart()
	handle_mouth()
	
func idle() -> void:
	heart_animator.play("heart_idle")
	
func die() -> void:
	heart_animator.play("heart_dying")
	for tentacle in tentacle_animators:
		tentacle.play("dead")
	
func panic() -> void:
	heart_animator.play("heart_stressed")
	for tentacle in tentacle_animators:
		tentacle.play("happy")
	
func feed(player: Player, item: Item) -> void:
	print("Fed it")
	if player != null and item == null:
		player.bite()
	pass
