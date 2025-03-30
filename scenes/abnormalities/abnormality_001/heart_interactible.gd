extends Interactible
class_name HeartInteractible

@onready var abnormality_001: Node3D = $"../.."

# Called when the node enters the scene tree for the first time.
func interact(player: Player) -> void:
	abnormality_001.pet(player)

func get_message() -> String:
	return "(" + Utils.get_key_of_action("interact") + ") pet me"
