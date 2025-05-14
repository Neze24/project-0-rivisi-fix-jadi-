extends Control

var drect = "user://Score.json"
var data
var score = "NO Best Score For Today :p"
@onready var s1 = $"Label/Label6/HScore 1"
@onready var s2 = $"Label2/Label4/Hscore 2"
@onready var s3 = $"Label3/Label5/Hscore 3"

@onready var Name1 = $Label/Label/Name1
@onready var Name2 = $Label2/Label/Name2
@onready var Name3 = $Label3/Label/Name3


func _ready() -> void:
	var file = FileAccess.open(drect, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var parsed = JSON.parse_string(content)

		s1.text = str(get_score(parsed, '1'))
		s2.text = str(get_score(parsed, '2'))
		s3.text = str(get_score(parsed, '3'))
		
		Name1.text = str(getname(parsed, '1'))
		Name2.text = str(getname(parsed, '2'))
		Name3.text = str(getname(parsed, '3'))
		
	else:
		s1.text = "NO Best Score For Today :p"
		s2.text = "NO Best Score For Today :p"
		s3.text = "NO Best Score For Today :p"
		
		Name1.text = "nobody"
		Name2.text = "nobody"
		Name3.text = "nobody"

func get_score(parsed: Dictionary, level: String) -> String:
	if parsed.has(level) and typeof(parsed[level]) == TYPE_DICTIONARY and parsed[level].has("best_score"):
		return str(int(parsed[level]["best_score"]))
	else:
		return "NO Best Score For Today :p"


func getname(parsed: Dictionary, level: String) -> String:
	if parsed.has(level) and typeof(parsed[level]) == TYPE_DICTIONARY and parsed[level].has("Name"):
		return str(parsed[level]["Name"])
	else:
		return "Nobody"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
