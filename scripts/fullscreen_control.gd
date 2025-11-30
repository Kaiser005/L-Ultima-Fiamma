extends CheckButton
@onready var fullscreen_control: CheckButton = $"."

func _ready() -> void:
	var current_mode = DisplayServer.window_get_mode()
	if current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN or current_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		# Se sì, mettiamo la spunta visiva
		fullscreen_control.button_pressed = true
	else:
		# Altrimenti la togliamo
		fullscreen_control.button_pressed = false


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
