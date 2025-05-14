extends Node2D

@onready var animation = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since tdhe previous frame.
func _process(delta):
	animation.play("default")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.key_obtained = true	
		queue_free()
		print("key obtained = ",Global.key_obtained)
