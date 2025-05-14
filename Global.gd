extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var player_alive = true
var key_obtained = false
var player_killed = false
var show_soal = false
var player_controling = false

var best_score = 0
var current_score
var stage = 1

var time_score 

var Player_name = "secret agent"

var time_limit = 0

var Stage_finish = false

var soal_passed = false
var dificulty = "Ez"

var go_to_stage

var time = 0
