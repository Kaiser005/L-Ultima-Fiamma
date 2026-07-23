extends Node


const FILE_START = "res://scenes/levels/livello_"
var score = 0
var needed_points = 0
var monete_raccolte_id = []
#var score_label: Label = null

func add_point():
	score += 1
#	score_label.text = "Hai collezionato " + str(score) + " monete!"

func _ready() -> void:
	call_deferred("coins_count")
	

func coins_count():
	var coin_list = get_tree().get_nodes_in_group("coin")
	#col .size do' l'int
	needed_points = coin_list.size()
	#print("totale monete ", needed_points)
	
func next_level():
	var current_scene = get_tree().current_scene.scene_file_path
	var next_scene = current_scene.to_int() + 1
	var next_scene_path = FILE_START + str(next_scene) + ".tscn"
	
	await FadeInOut.fade_in()
	
	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else: 
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	await FadeInOut.fade_out()
	

func reset():
	score = 0
	monete_raccolte_id.clear()

func go_to_menu(): 
	await FadeInOut.fade_in()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	await FadeInOut.fade_out()
