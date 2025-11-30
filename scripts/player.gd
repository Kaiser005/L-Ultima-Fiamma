extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
# Aggiungi un segnale che useremo per dire al gioco "Sono morto!"
signal player_died

# Costanti per la morte
const DEATH_JUMP_VELOCITY = -300.0 # Quanto in alto salta alla morte (negativo = su)
const GRAVITY = 980.0 # O usa la tua gravità di progetto

var is_dead = false

func _physics_process(delta: float) -> void:
	# Se il giocatore è morto, gestisci solo la caduta
	if is_dead:
		# Applica la gravità
		velocity.y += GRAVITY * delta
		# Muovi la posizione manualmente, ignorando le collisioni
		# NON usiamo più move_and_slide() qui!
		position.y += velocity.y * delta
		return # Non eseguire il codice di movimento normale

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else: 
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	

	move_and_slide()
func die() -> void:
	# Assicurati che questa funzione venga eseguita solo una volta
	if is_dead:
		return
		
	is_dead = true
	
	# Emetti il segnale per avvisare il gioco
	player_died.emit()
	animated_sprite_2d.play("jump")
	
	# Disabilita le collisioni per poter "cadere dalla mappa"
	$CollisionShape2D.disabled = true
	
	# Applica l'impulso del salto di morte
	velocity.y = DEATH_JUMP_VELOCITY
