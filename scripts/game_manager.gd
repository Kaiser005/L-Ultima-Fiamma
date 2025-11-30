extends Node

var score = 0
var needed_points = 17
@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "Hai collezionato " + str(score) + " monete!"
