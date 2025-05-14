extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.Player_name = "secret agent"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://PLayerName.tscn")
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://statistic.tscn")

func _on_button_3_pressed() -> void:
	get_tree().quit()
