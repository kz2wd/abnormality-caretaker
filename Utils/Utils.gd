extends Node


func get_key_of_action(action: String) -> String:
	var events = InputMap.action_get_events(action)
	for event in events:
		if event is InputEventKey:
			print(event)
			return OS.get_keycode_string(event.get_key_label_with_modifiers())
	return "UNBOUND"
