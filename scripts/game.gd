extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var death_timer = $DeathTimer # Aggiungi un Timer chiamato "DeathTimer"
@onready var game_over_screen: Control = $GameOver/GameOver

func _ready() -> void:
	
	# Collega il segnale 'player_died' che abbiamo creato nel player
	# a una nuova funzione in questo script
	player.player_died.connect(_on_player_died)
	
	# Collega il segnale 'timeout' del nostro timer
	death_timer.timeout.connect(_on_death_timer_timeout)


# Questa funzione viene chiamata quando il giocatore emette il segnale 'player_died'
func _on_player_died() -> void:
	# Attiva lo slow-motion
	Engine.time_scale = 0.75
	
	# Avvia il timer. Regola questo valore (in secondi)
	# per dare al giocatore il tempo di cadere
	death_timer.wait_time = 1.0
	death_timer.start()


# Questa funzione viene chiamata quando il DeathTimer ha finito
func _on_death_timer_timeout() -> void:
	# Rimetti il tempo alla normalità
	Engine.time_scale = 1.0
	
	# E ora mostra la schermata di Game Over
	game_over_screen.show()
