extends Area2D


# Called when the node enters the scene tree for the first time.
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var mio_id = str(get_path())
	if GameManager.monete_raccolte_id.has(mio_id):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.add_point()
		var mio_id = str(get_path())
		GameManager.monete_raccolte_id.append(mio_id)
		collision.set_deferred("disabled", true)
		animation_player.play("pickup")
		await animation_player.animation_finished
		queue_free()
