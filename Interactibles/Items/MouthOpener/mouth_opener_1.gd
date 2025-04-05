extends Interactible
class_name MouthOpener
# THIS CLASS IS GONNA BE GARBAGE TIER :D
# I say it proudly because it's just a proof of concept

@onready var mouth_animator: AnimationPlayer = $mouth/AnimationPlayer
@onready var mouth_sound: AudioStreamPlayer3D = $mouth/mouth_sound
const MUNCHING = preload("res://scenes/abnormalities/abnormality_001/assets/sounds/munching.wav")

@export var door: CSGPrimitive3D

enum {UNSTARTED, ATE_A_WRENCH, ATE_MUSIC_BOX}
var state = UNSTARTED

var dialog = {
	UNSTARTED: ["Hey...", "Feed me!", "I want something good", "Something crunchy", "Go get it"],
	ATE_A_WRENCH: ["Mmmh", "Well", "Wasn't expecting that", "Find me something else"],
	ATE_MUSIC_BOX: ["mmh", "nice", "thank"],
	}
var dialog_index = 0
var special_dialogs = []
func get_dialog() -> String:
	if len(special_dialogs) != 0:
		return special_dialogs[0]
	var phase_dialog = dialog[state]
	if dialog_index >= len(phase_dialog):
		dialog_index = len(phase_dialog) - 1
	return phase_dialog[dialog_index]
	
func increase_dialog():
	if len(special_dialogs) > 0:
		special_dialogs.pop_front()
	else:
		dialog_index += 1

func change_phase(new_phase):
	dialog_index = 0
	state = new_phase
	

func interact(player: Player) -> void:
	if mouth_sound.is_playing():
		return
	var item =  player.current_item
	
		
	match state:
		UNSTARTED:
			increase_dialog()
			if dialog_index <= 2:
				return
			if item is WrenchItem:
				player.remove_current_item()
				item.delete()
				play_eating_animation()
				change_phase(ATE_A_WRENCH)
			elif item is Abnormality002:
				player.remove_current_item()
				item.delete()
				play_eating_animation()
				change_phase(ATE_MUSIC_BOX)
		ATE_A_WRENCH:
			increase_dialog()
			if item is WrenchItem and len(special_dialogs) == 0:
				special_dialogs = ["no", "I want something different"]
			if item is Abnormality002:
				player.remove_current_item()
				item.delete()
				play_eating_animation()
				change_phase(ATE_MUSIC_BOX)
		ATE_MUSIC_BOX:
			increase_dialog()
			if dialog_index >= 2:
				print("OPENING DOOR :D")
				if door != null:
					door.operation = CSGShape3D.OPERATION_SUBTRACTION
	
	

func get_message() -> String:
	return "(" + Utils.get_key_of_action("interact") + ") " + get_dialog()

func handle_mouth() -> void:
	if !mouth_animator.is_playing() and !mouth_sound.is_playing():
		mouth_animator.play("mouth_idle")


func play_eating_animation() -> void:
	mouth_animator.play("mouth_chewing", 1, 0.8)
	mouth_sound.stream = MUNCHING
	mouth_sound.play(0.1)


func _process(delta: float) -> void:
	handle_mouth()
