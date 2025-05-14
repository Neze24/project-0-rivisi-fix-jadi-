extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var player_in_range = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var interacted = Input.is_action_just_pressed("interact")
	
	if Global.soal_passed :
		queue_free()
		
	elif player_in_range and interacted and not Global.soal_passed :
		print("perlu mengerjakan soal")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
