extends Node2D
@onready var animation = $CharacterBody2D/AnimatedSprite2D
func _physics_process(delta: float) -> void:
	animation.play("default")
	
