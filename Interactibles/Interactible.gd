extends CollisionObject3D
class_name Interactible

# Abstract method to be implemented by derived classes
func interact(player: Player) -> void:
	pass

func get_message() -> String:
	return "(" + Utils.get_key_of_action("interact") + ") iteract"
