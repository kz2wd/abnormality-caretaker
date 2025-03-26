extends Node3D

@onready var heart_animator: AnimationPlayer = $heart2/AnimationPlayer

@onready var tentacle_animators: Array[AnimationPlayer] = [
	$trunk/tentacle2/AnimationPlayer,
	$trunk/tentacle3/AnimationPlayer,
	$trunk/tentacle4/AnimationPlayer,
]

@onready var breath_in: Resource = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/br1_in.wav")
@onready var breath_out: Resource = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/br1_out.wav")

@onready var breath_sound_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

enum BREATH {
	IN,
	OUT
}

# first played pattern is the opposite of the one put here
var current_breath_pattern = BREATH.OUT

func play_breath_in() -> void:
	current_breath_pattern = BREATH.IN
	breath_sound_player.stream = breath_in
	breath_sound_player.play()
	for tentacle in tentacle_animators:
		tentacle.play("idle_in")
	
func play_breath_out() -> void:
	current_breath_pattern = BREATH.OUT
	breath_sound_player.stream = breath_out
	breath_sound_player.play()
	for tentacle in tentacle_animators:
		tentacle.play("idle_out")

func handle_breath() -> void:
	# If no breathing is occuring (based on sound player), then trigger the next one
	if !breath_sound_player.is_playing():
		if current_breath_pattern == BREATH.IN:
			play_breath_out()
		else:
			play_breath_in()
		

var animations = [idle, panic, die]
var current_animation_index = 0


func _process(delta: float) -> void:
	handle_breath()
	if Input.is_action_just_pressed("test_circle_animations"):
		animations[current_animation_index].call()
		current_animation_index += 1
		current_animation_index %= len(animations)
	
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
	
