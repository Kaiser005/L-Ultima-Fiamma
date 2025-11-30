extends Area2D

# Assicurati che il tuo Player sia nel gruppo "player"
# (Seleziona il Player -> Nodo -> Gruppi -> scrivi "player" -> Aggiungi)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Chiama la funzione 'die' che abbiamo creato nello script del giocatore
		body.die()
