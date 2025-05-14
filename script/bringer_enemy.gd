extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var lable = $Label

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed = 75
var pushSpeed = 10
var chase_left = false
var chase_right = false

var alive = true
var damage = 10
var damagecd = false
var health = 50

var attack_ava = true
var flip = false 
var plyr_on_range = false
var attack_timer = 0.0
var atk_cd = 2
var attacking = false

var pushleft = false
var pushright = false
var pushed = false



func _physics_process(delta):
	
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var control = Input.is_action_just_pressed("interact")
	
	if control and plyr_on_range and not Global.player_controling :
		Global.player_controling = true
		print("player controling")
	elif control and plyr_on_range and Global.player_controling :
		print("player not controling")
		Global.player_controling = false
	
	if plyr_on_range and not Global.player_controling : 
			lable.visible = true
	else : 
		lable.visible = false
	
	# Chase handler
	if left and Global.player_controling and plyr_on_range or left and pushright:
		if pushright:
			velocity.x = -pushSpeed
		else:
			velocity.x = -speed
			animation.play("walk")
			animation.flip_h = true
			print(velocity.x)
	elif right and Global.player_controling and plyr_on_range or right and pushleft:
		if pushleft:
			velocity.x = pushSpeed
		else:
			velocity.x = speed
			animation.play("walk")
			animation.flip_h = false
	else:
		velocity.x = 0
		animation.play("idle")

	if not is_on_floor():
		velocity.y += gravity * delta
		
	if health <= 0:
		health = 0
		alive = false

	if not alive:
		animation.visible = false

	# Attack handler 
	

	move_and_slide()


func _on_death_animation_finished() -> void:
	queue_free()


# Attack flip detection
func _on_attack_3_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		plyr_on_range = true

func _on_attack_3_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.player_controling = false
		plyr_on_range = false
	


func _on_push_left_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pushleft = true
	

func _on_push_left_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		pushleft = false
	


func _on_push_right_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pushright = true


func _on_push_right_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		pushright = false
