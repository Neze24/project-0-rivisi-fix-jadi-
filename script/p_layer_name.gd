extends Control

@onready var input = $Input

func _ready() -> void:
	input.grab_focus()
	$Label2.visible = false

func _on_button_pressed() -> void:
	Global.stage = 1
	Global.go_to_stage = "res://stage1.tscn"
	if input.text.strip_edges() == "":
		$Label2.visible = true
	else:
		Global.Player_name = input.text.strip_edges() 
		get_tree().change_scene_to_file("res://stage_select.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
