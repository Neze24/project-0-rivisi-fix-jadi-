extends Node2D

@onready var animation = $AnimatedSprite2D
@onready var lable = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var player_inRange = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animation.play("default")
	if player_inRange and not Global.show_soal and not Global.soal_passed : 
		lable.visible = true
	else : 
		lable.visible = false
	
	var interacted = Input.is_action_just_pressed("interact")
	if player_inRange and interacted and not Global.soal_passed :
		if Global.show_soal:
			Global.show_soal = false
		else : 
			Global.show_soal = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inRange = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inRange = false
