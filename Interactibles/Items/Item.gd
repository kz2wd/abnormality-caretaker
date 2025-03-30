extends Interactible
class_name Item

var food_type: Global.FOOD_TYPE = Global.FOOD_TYPE.SCRAP
var is_held := false

func interact(player: Player) -> void:
	if is_held:
		player.try_drop_on_ground(self)
		return
	player.try_hold(self)
