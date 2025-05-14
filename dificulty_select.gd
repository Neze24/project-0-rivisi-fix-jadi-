extends Control
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.go_to_stage)
	Global.dificulty = "Hard"
	Global.time_limit = 40
	
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(Global.go_to_stage)
	Global.dificulty = "Normal"
	Global.time_limit = 60
	
func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file(Global.go_to_stage)
	Global.dificulty = "Ez"
	Global.time_limit = 100
	


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://PLayerName.tscn")
