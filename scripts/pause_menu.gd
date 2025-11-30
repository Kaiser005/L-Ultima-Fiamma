extends Control
@onready var options: Panel = $PanelContainer/Options
@onready var pause_menu: Control = $"."
@onready var pausa: Panel = $PanelContainer/Pausa

func _ready() -> void:
	$AnimationPlayer.play_backwards("RESET")
	pause_menu.hide()

func resume(): 
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	pause_menu.show()
	get_tree().paused = true
	_on_back_2_pressed()
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("pause or back") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause or back") and get_tree().paused == true:
		resume()
	

func _on_resume_pressed() -> void:
	resume()


func _on_option_pressed() -> void:
	options.visible = true
	pausa.visible = false

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _process(_delta: float) -> void:
	testEsc()
	

func _on_back_2_pressed() -> void:
	options.visible = false
	pausa.visible = true
