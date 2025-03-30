extends Interactible
class_name MouthInteractible

@onready var abnormality_001: Node3D = $"../.."

# Called when the node enters the scene tree for the first time.
func interact(player: Player) -> void:
	var item = player.remove_current_item()
	abnormality_001.feed(player, item)

func get_message() -> String:
	return "Press " + Utils.get_key_of_action("interact") + " to feed me"
