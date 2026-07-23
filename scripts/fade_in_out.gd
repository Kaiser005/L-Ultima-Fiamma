extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	color_rect.visible = false
	color_rect.modulate.a = 0

func fade_in():
	color_rect.visible = true
	animation_player.play("fade")
	await animation_player.animation_finished

func fade_out():
	animation_player.play("fade_out")
	await animation_player.animation_finished
	color_rect.visible = false
