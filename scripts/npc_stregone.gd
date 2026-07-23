extends StaticBody2D
@onready var interaction_key: Label = $Interaction_key
@onready var textbox: CanvasLayer = $"../Textbox"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var coins = 0
var coins_needed = 0
var player_ref: Node2D = null
var livello = 0
var max_chars = 121


enum State{
	IsInArea,
	IsNotinArea
}
var current_state = State.IsNotinArea
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_key.modulate.a = 0.0
	call_deferred("level_number")


func _process(_delta: float) -> void:
	coins = GameManager.score
	coins_needed = GameManager.needed_points
	
	
	if player_ref != null:
		turn()

	if (current_state == State.IsInArea && Input.is_action_just_pressed("interaction")):
		#get_tree().paused = true
		dialogo()
		
		if(coins == coins_needed):
			bonus()
			



@warning_ignore("unused_parameter")
func _on_interaction_area_body_entered(body: Node2D) -> void:
	#print("Qualcosa è entrato: ", body.name) # DEBUG
	if body.is_in_group("player"):
		change_state(State.IsInArea)
		player_ref = body

@warning_ignore("unused_parameter")
func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		change_state(State.IsNotinArea)
		player_ref = null
	
func turn():
	#player a sinistra
	if player_ref.global_position.x < global_position.x:
		animated_sprite_2d.flip_h = false
	#a destra
	else:
		animated_sprite_2d.flip_h = true

func showkey():
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(interaction_key, "modulate:a", 1.0, 0.3)

func hidekey():
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(interaction_key, "modulate:a", 0.0, 0.3)
	
func dialogo():
	get_tree().call_group("player", "freeze")
	textbox.show()
	
	
	
	var discorso = []
	match livello:
		1:
			discorso = ["Vedo che sei giunto fin qui, cavaliere. La fatica ti segna il volto, ma la vera prova deve ancora iniziare. Le ombre di questo luogo hanno inghiottito legioni di tuoi simili. Soltanto un'unica fiamma ha brillato abbastanza da raggiungere il trono: il Cavaliere Puro. Desideri ardere come lui o spegnerti nell'oblio? Senza una guida, il tuo fallimento è certo. Per ora, accetta la mia benevolenza gratuita. Ma sappi questo: la conoscenza arcana non è mai priva di costi. Al nostro prossimo incontro, pretenderò il giusto compenso. Non temere... non rimpiangerai ciò che dovrai offrire. "]
			get_tree().call_group("gestore_dialoghi", "set_next_level_trigger", true)
	for blocco_testo in discorso:
		var pagine = split_text(blocco_testo, max_chars)
		
		for pagina in pagine:
			get_tree().call_group("gestore_dialoghi", "queue_text", pagina)
	#GameManager.next_level()

func bonus():
	print("sono nella funzione bonus")
	var discorso_bonus = []
	textbox.show()
	match livello:
		1:
			discorso_bonus = ["Vedo che hai raccolto tutte le monete, queste ti serviranno per comprare nuovi utensili nel negozio di Babu, proseguendo avrai il piacere di conoscerlo. Ora vai e procedi alla prossima sfida che ti attende!"]
	for blocco_testo in discorso_bonus:
		var pagine = split_text(blocco_testo, max_chars)
	
		for pagina in pagine:
			get_tree().call_group("gestore_dialoghi", "queue_text", pagina)
	


func split_text(text: String, limit: int) -> Array:
	var pages = []
	
	while len(text) > limit:
		#mentre il testo è più lungo del limite cerco da destra verso sinistra il primo spazio disponibile, partendo dal limite, col comando text.rfind
		var split_index = text.rfind(" ", limit)
		
		#controllo se non trova spazi, come nel caso in cui una parola sia lunghissima
		if split_index == -1:
			split_index = limit #forzo il taglio
		
		#aggiungo il pezzo tagliato al resto della lista
		pages.append(text.substr(0, split_index))
		
		#rimuovo il pezzo appena aggiunto dal resto delle pagine
		text = text.substr(split_index + 1)	 # +1 salta lo spazio che abbiamo lasciato nel taglio
		
	pages.append(text) #aggiungo il resto minore del limite
	
	return pages

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.IsInArea:
			showkey()
		State.IsNotinArea:
			hidekey()
		
func level_number():
	var current_scene = get_tree().current_scene.scene_file_path
	var n_level = current_scene.to_int()
	livello = n_level
