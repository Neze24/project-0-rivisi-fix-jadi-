extends Control


func _physics_process(delta):
	$ColorRect2/Timer.text = str(int(Global.time_score))
	if Global.Stage_finish or get_tree().paused or Global.show_soal or not Global.player_alive :
		visible = false
	else : 
		visible =true
  
