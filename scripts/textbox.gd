extends CanvasLayer

@onready var textbox: MarginContainer = $TextboxContainer
@onready var start: Label = $TextboxContainer/MarginContainer/HBoxContainer/start
@onready var label: Label = $TextboxContainer/MarginContainer/HBoxContainer/Label
@onready var end: Label = $TextboxContainer/MarginContainer/HBoxContainer/end
const char_read_rate = 0.03
var tween: Tween

enum State{
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = [] 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()

func _process(_delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				change_state(State.READING)
				print("TEXTBOX: Coda piena, inizio a leggere!")
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				if tween: tween.kill()
				on_tween_finished()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)
	print("TEXTBOX: Ho ricevuto il messaggio -> ", next_text)

func hide_textbox(): 
	textbox.hide()
	start.text = ""
	label.text = ""
	end.text = ""

func show_textbox():
	textbox.show()
	start.text = "*"

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	show_textbox()
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * char_read_rate)
	tween.connect("finished", on_tween_finished)
	print("TEXTBOX: Mostro il box e il testo")
	
func on_tween_finished():
	end.text = "v"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			pass
		State.READING:
			display_text()
		State.FINISHED:
			pass
