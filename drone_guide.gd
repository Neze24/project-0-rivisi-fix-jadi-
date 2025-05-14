extends CharacterBody2D

@onready var animation = $Area2D/AnimatedSprite2D
@export var markers: Array[Marker2D]
var current_marker_index := 0
var moving: bool = false

func _process(delta: float) -> void:
	if moving:
		animation.play("walk")
	else:
		animation.play("idle")

func _physics_process(delta: float) -> void:
	if moving and current_marker_index < markers.size():
		var target = markers[current_marker_index].global_position
		var direction = (target - global_position).normalized()
		velocity = direction * 200
		move_and_slide()

		animation.flip_h = direction.x < 0

		if global_position.distance_to(target) <= 5.0:
			moving = false
			current_marker_index += 1
			velocity = Vector2.ZERO

			if current_marker_index >= markers.size():
				moving = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if current_marker_index < markers.size():
		moving = true
