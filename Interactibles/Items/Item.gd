extends Interactible
class_name Item

var food_type: Global.FOOD_TYPE = Global.FOOD_TYPE.SCRAP
var is_held := false
var in_hand_rotation: Vector3 = Vector3(0, 0, 0)

func interact(player: Player) -> void:
	if is_held:
		player.try_drop_on_ground(self)
		return
	player.try_hold(self)
	
func delete():
	self.queue_free()
