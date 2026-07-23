extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var start: Button = $Start
@onready var options: Panel = $Options
@onready var fullscreen_control: CheckButton = $Options/FullscreenControl


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	start.visible = true
	options.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause or back"):
		_ready()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/livello_1.tscn")

func _on_option_pressed() -> void:
	main_buttons.visible = false
	start.visible = false
	options.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	_ready()
