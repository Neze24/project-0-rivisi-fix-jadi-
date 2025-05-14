extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Stage_finish = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Global.Stage_finish:
		Global.time += delta
		Global.time_score -= delta
		
	if Global.time_score <= 0:
		Global.player_killed = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.player_killed = true
		


func _on_finish_line_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print(Global.time)
		Global.Stage_finish = true
