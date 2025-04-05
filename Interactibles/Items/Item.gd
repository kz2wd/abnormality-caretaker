extends Interactible
class_name Item

var food_type: Global.FOOD_TYPE = Global.FOOD_TYPE.SCRAP
var is_held := false
var in_hand_rotation: Vector3 = Vector3(0, 0, 0)
var go_to_target = false
var target_position: Vector3 = Vector3(0, 0, 0)
var target_rotation: Vector3 = Vector3(0, 0, 0)

var lerp_speed = 10.0


func _process(delta: float) -> void:
	if go_to_target:
		position = lerp(position, target_position, delta * lerp_speed)
		rotation = lerp(rotation, target_rotation, delta * lerp_speed)

func interact(player: Player) -> void:
	if is_held:
		player.try_drop_on_ground(self)
		return
	player.try_hold(self)
	
func delete():
	self.queue_free()
