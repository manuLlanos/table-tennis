extends Node2D

var ball_scene: PackedScene = preload("res://scenes/ball.tscn")
var game_paused: bool = false

func _ready():
	Engine.time_scale = 1
	$UI/PauseMenu.hide()
	$PaddleRight.player_number = 0
	match Globals.players:
		1:
			$PaddleLeft.player_number = 2
		2:
			$PaddleLeft.player_number = 1

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
func _on_left_goal_area_body_entered(_body):
	Globals.right_player_score += 1


func _on_right_goal_area_body_entered(_body):
	Globals.left_player_score += 1

func pauseMenu():
	if not game_paused:
		game_paused = true
		Engine.time_scale = 0
		$UI/PauseMenu.show()
	else:
		game_paused = false
		Engine.time_scale = 1
		$UI/PauseMenu.hide()
