extends CharacterBody2D

var speed = 150.0
var JUMP_VELOCITY = -400.0
@export var dash_speed = 1500
@export var dash_cd = 1
@export var cd_atk = 0.4

@export var knockback_force = 400
@export var knockback_duration = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = $AnimatedSprite2D
@onready var attacknim = $Attacknim
@onready var dashnim = $dashnim
@onready var attacknimh = $Attacknimflip
@onready var death = $death
@onready var hit = $hit

var is_knocked_back := false
var knockback_timer := 0.0

var dashing = false
var while_dash = false
var dash_timer = 0

var special_atk = false
var justSatk = false

var atk_timer = 0.0
var attacking = false
var while_atk = false
var justAttkd = false

var infi = false
var can_take_damage = true

var attack_ = false
var attack_h = false
var enemyIrange = false
var damage = 0  
var health = 100
var alive = true

var can_beattacked = false

var just_hit = false

func _ready() -> void:
	attacknim.connect("animation_finished", Callable(self, "_onAttackFinished"))
	attacknimh.connect("animation_finished", Callable(self, "_onAttackFinished"))
	dashnim.connect("animation_finished", Callable(self, "_onAttackFinished"))
	Global.key_obtained = false
	Global.soal_passed = false
	Global.player_alive = true
	Global.player_killed = false
	Global.show_soal = false
	Global.player_controling = false
	Global.Stage_finish = false
	Global.time_score = Global.time_limit
	Global.time = 0
	
func _onAttackFinished():
	if attacking:
		attacknimh.visible = false
		attacking = false
		while_atk = false
		animation.visible = true
		attacknim.visible = false
		damage = 0
		
func _physics_process(delta):
	
	if not Global.player_killed :
		death.visible = false
		if Global.player_controling:
			velocity.x = 0
		if not just_hit:
			if !attacking and not just_hit:
				hit.visible = false
				attacknimh.visible = false
				animation.visible = true
				attacknim.visible = false
				dashnim.visible = false 
				
			# Add gravity
			if not is_on_floor():
				velocity.y += gravity * delta
				if velocity.y > 0:
					animation.play("fall")
				
			var right = Input.is_action_pressed("right")
			var left = Input.is_action_pressed("left")
			var jump = Input.is_action_just_pressed("jump")
			var InDash = Input.is_action_just_pressed("dash")
			
			# Jump handler
			if jump and is_on_floor() and not Global.player_controling and not Global.show_soal and not Global.Stage_finish:
				velocity.y = JUMP_VELOCITY
				if not while_dash:
					animation.play("jump")
				
			# Direction handler
			if right and not while_dash and not Global.player_controling and not Global.show_soal and not Global.Stage_finish:
				velocity.x = speed
				if is_on_floor() and not jump and not Global.player_controling and not Global.show_soal and not Global.Stage_finish:
					animation.play("run")
				animation.flip_h = false
			elif left and not while_dash and not Global.player_controling and not Global.show_soal and not Global.Stage_finish:
				velocity.x = -speed
				if is_on_floor() and not jump:
					animation.play("run")
				animation.flip_h = true
			else:
				velocity.x = move_toward(velocity.x, 0, speed)
				if is_on_floor() and not jump and not while_dash:
					animation.play("default")
				
			# Dash handler
			if InDash and not dashing and not Global.player_controling and not Global.show_soal and not Global.Stage_finish:
				special_atk = true
				animation.visible = false
				velocity.y = 0
				dashing = true
				while_dash = true
				if left:
					velocity.x = -dash_speed
				elif right:
					velocity.x = dash_speed
				else:
					if animation.flip_h == true:
						velocity.x = -dash_speed
					else:
						velocity.x = dash_speed
				
			if velocity.x == 0:
				while_dash= false 
				
			# Dash cooldown
			if dashing:
				dash_timer += delta
				if dash_timer >= dash_cd:
					dashing = false
					dash_timer = 0
				
	else:
		velocity.x = 0
		velocity.y = 250
		animation.visible = false
		if not death.visible:
			death.visible = true;
			death.play("death");
	
	move_and_slide()
	
func player():
	pass
	
#deafult
func _on_atk_area_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemyIrange= true
		attack_ = true
		

func _on_atk_area_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		attack_ = true
		enemyIrange= false

#flip
func _on_atk_area_2_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemyIrange= true
		attack_h  =true
	
func _on_atk_area_2_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		attack_h = false
		enemyIrange= false
	
func _on_death_animation_finished() -> void:
	animation.visible = false
	Global.player_alive = false
	
func _on_hit_animation_finished() -> void:
	animation.visible = true
	hit.visible = false
	just_hit = false
	print (health)
