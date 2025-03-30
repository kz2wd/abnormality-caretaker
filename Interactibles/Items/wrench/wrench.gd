extends Item
class_name WrenchItem

func _init() -> void:
	food_type = Global.FOOD_TYPE.METAL 

func get_message() -> String:
	return "(" + Utils.get_key_of_action("interact") + ") grab wrench"
