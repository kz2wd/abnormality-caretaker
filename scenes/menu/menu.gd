extends Control

const MAIN = preload("res://scenes/main.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN)
