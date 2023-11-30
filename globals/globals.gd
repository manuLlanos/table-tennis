extends Node

var players: int = 1

signal score

var left_player_score: int = 0:
	set(value):
		left_player_score = value
		score.emit()

var right_player_score: int = 0:
	set(value):
		right_player_score = value
		score.emit()

# for ai purposes
var ball_pos: Vector2
var ball_velocity: Vector2
