extends StaticBody2D
@onready var interaction_key: Label = $Interaction_key
@onready var textbox: CanvasLayer = $"../Textbox"

enum State{
	IsInArea,
	IsNotinArea
}
var current_state = State.IsNotinArea
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_key.modulate.a = 0.0
	

func _process(_delta: float) -> void:
	if (current_state == State.IsInArea && Input.is_action_just_pressed("interaction")):
		#get_tree().paused = true
		dialogo()


@warning_ignore("unused_parameter")
func _on_interaction_area_body_entered(body: Node2D) -> void:
	#print("Qualcosa è entrato: ", body.name) # DEBUG
	if body.is_in_group("player"):
		change_state(State.IsInArea)

@warning_ignore("unused_parameter")
func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		change_state(State.IsNotinArea)	
	
	
func showkey():
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(interaction_key, "modulate:a", 1.0, 0.3)

func hidekey():
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(interaction_key, "modulate:a", 0.0, 0.3)
	
func dialogo():
	var discorso = ["Vedo che sei giunto fin qui, cavaliere. La fatica ti segna il volto, ma la vera prova deve ancora iniziare.", "Le ombre di questo luogo hanno inghiottito legioni di tuoi simili.", "Soltanto un'unica fiamma ha brillato abbastanza da raggiungere il trono: il Cavaliere Puro.", "Desideri ardere come lui o spegnerti nell'oblio? Senza una guida, il tuo fallimento è certo.
", "Per ora, accetta la mia benevolenza gratuita. Ma sappi questo: la conoscenza arcana non è mai priva di costi.", "Al nostro prossimo incontro, pretenderò il giusto compenso. Non temere... non rimpiangerai ciò che dovrai offrire."]
	textbox.show()
	for frase in discorso:
		get_tree().call_group("gestore_dialoghi", "queue_text", frase)


func change_state(next_state):
	current_state = next_state
	match current_state:
		State.IsInArea:
			showkey()
		State.IsNotinArea:
			hidekey()
		
	
