extends Node2D

@onready var lable = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var player_on_range = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var interacted = Input.is_action_just_pressed("interact")
	
	if player_on_range and interacted and Global.key_obtained :
		queue_free()
		
	elif player_on_range and interacted and not Global.key_obtained :
		$Label.text = "Need a Key"
	elif not player_on_range:
		$Label.text = "press E to open"
		lable.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_on_range = true
		lable.visible= true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_on_range = false
