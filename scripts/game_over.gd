extends Control

@onready var game_over: Control = $"."

func _ready() -> void:
	game_over.hide()

func _on_retry_pressed() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	Engine.time_scale = 1.0
