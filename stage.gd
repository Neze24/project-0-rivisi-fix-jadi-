extends Node2D



func _process(delta: float) -> void:
	if not Global.Stage_finish:
		Global.time += delta
		Global.time_score -= delta
		
	if Global.time_score <= 0:
		Global.player_killed = true


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.player_killed = true
	

func _on_finish_line_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.Stage_finish = true



func _on_lava_2_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.player_killed = true


func _on_dev_room_body_entered(body: Node2D) -> void:
	if body.has_method("player") :
		get_tree().change_scene_to_file("res://bg.tscn")
