extends Control

var quiz_data:Variant
var answer
var selected
var cAnswer:String
var randomizer=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file = FileAccess.open("res://saves/Soal.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var parsed = JSON.parse_string(content)
		quiz_data = parsed[Global.dificulty]
		randomizer = randi() % quiz_data.size()
		
	

@onready var animation = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	selected = quiz_data[randomizer]
	animation.play("default")
	visible = Global.show_soal
	
	$ColorRect/question.text = selected["question"]
	$choice1.text = selected["choices"][0]
	$choice2.text = selected["choices"][1]
	$choice3.text = selected["choices"][2]
	cAnswer = selected["answer"]

	
func _on_button_2_pressed() -> void:
	Global.show_soal = false


func _on_choice_1_pressed() -> void:
	print(cAnswer)
	answer = selected["choices"][0]
	if answer == cAnswer:
		Global.soal_passed = true
		Global.show_soal = false
	elif answer != cAnswer:
		Global.show_soal = false
		randomizer = randi() % quiz_data.size()

func _on_choice_2_pressed() -> void:
	answer = selected["choices"][1]
	if answer == cAnswer:
		Global.soal_passed = true
		Global.show_soal = false
	elif answer != cAnswer:
		Global.show_soal = false
		randomizer = randi() % quiz_data.size()
		
func _on_choice_3_pressed() -> void:
	answer = selected["choices"][2]
	if answer == cAnswer:
		Global.soal_passed = true
		Global.show_soal = false
	elif answer != cAnswer:
		Global.show_soal = false
		randomizer = randi() % quiz_data.size()
