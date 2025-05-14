extends Control

func _ready():
	get_tree().paused = false  # Ensure game starts unpaused
	visible = false  # Hide pause menu by default

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func Esc():
	if Input.is_action_just_pressed("pause") and not Global.show_soal:
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_button_pressed() -> void:
	resume()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")

func _physics_process(delta: float) -> void:
	visible = get_tree().paused
	Esc()


func _on_button_3_pressed() -> void:
	get_tree().reload_current_scene()
