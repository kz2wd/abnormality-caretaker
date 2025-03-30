extends Node

func get_key_of_action(action: String) -> String:
	var events = InputMap.action_get_events("interact")
	for event in events:
		if event is InputEventKey:
			
			return OS.get_keycode_string(event.physical_keycode)
	return "UNBOUND"
