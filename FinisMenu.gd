extends Control

var drect = "user://Score.json"
var time_factor = 2000.0
var multiplyer 
var time_score

func _ready() -> void:
	visible = false
	load_best_score()

func _physics_process(delta):
	if Global.Stage_finish:
		time_score = clamp(time_factor / Global.time, 0, 100)
		visible = true
		
		if Global.dificulty == "Ez":
			multiplyer = 1.0
		elif Global.dificulty == "Normal":
			multiplyer = 1.25
		elif Global.dificulty == "Hard":
			multiplyer = 1.5
			
		Global.current_score = time_score * multiplyer

		if Global.current_score > Global.best_score:
			Global.best_score = Global.current_score
			save_best_score()

		$ColorRect/Label/Label.text = str(int(Global.time_score))
		$ColorRect/Label2/Pass.text = Global.dificulty
		$ColorRect/Label3/score.text = str(int(Global.current_score))
		$ColorRect/Label5/bestScore.text = str(int(Global.best_score))
	else:
		visible = false
		
	

func save_best_score():
	var save_data := {}

	if FileAccess.file_exists(drect):
		var file = FileAccess.open(drect, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var existing = JSON.parse_string(content)
		if typeof(existing) == TYPE_DICTIONARY:
			save_data = existing

	
	var stage_key = str(Global.stage)

	
	save_data[stage_key] = {
		"best_score": Global.best_score,
		"Name":Global.Player_name
	}
	print(save_data, ' // ', stage_key);

	
	var file = FileAccess.open(drect, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_best_score():
	var stage_key = str(Global.stage)

	if FileAccess.file_exists(drect):
		var file = FileAccess.open(drect, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var result = JSON.parse_string(content)
		if typeof(result) == TYPE_DICTIONARY and result.has(stage_key):
			Global.best_score = result[stage_key].get("best_score", 0)
		else:
			Global.best_score = 0
	else:
		Global.best_score = 0

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_button_pressed() -> void:
	if Global.stage == 1:
		Global.stage = 2
		get_tree().change_scene_to_file("res://Stage.tscn")
	elif Global.stage == 2:
		Global.stage = 3
		get_tree().change_scene_to_file("res://stage_3.tscn")
	elif Global.stage == 3:
		get_tree().change_scene_to_file("res://menu.tscn")

func _on_reset_pressed() -> void:
	if get_tree().current_scene:
		get_tree().reload_current_scene()
	else:
		push_warning("⚠️ Cannot reload: current scene is null.")
