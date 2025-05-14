extends Control



func _on_stage_1_pressed() -> void:
	Global.go_to_stage = "res://stage1.tscn"
	Global.stage=1
	get_tree().change_scene_to_file("res://dificulty_select.tscn")


func _on_stage_2_pressed() -> void:
	Global.go_to_stage = "res://Stage.tscn"
	Global.stage=2
	get_tree().change_scene_to_file("res://dificulty_select.tscn")


func _on_stage__3_pressed() -> void:
	Global.go_to_stage = "res://stage_3.tscn"
	Global.stage=3
	get_tree().change_scene_to_file("res://dificulty_select.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
