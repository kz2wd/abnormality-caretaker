extends Interactible
class_name Item


var is_held := false

func interact(player: Player) -> void:
	if is_held:
		return
	player.try_hold(self)
