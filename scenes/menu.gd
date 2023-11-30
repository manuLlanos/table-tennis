extends Control

func _on_one_player_pressed():
	Globals.players = 1
	start_game()


func _on_two_players_pressed():
	Globals.players = 2
	start_game()

func start_game():
	get_tree().change_scene_to_file("res://scenes/field.tscn")

func _on_exit_pressed():
	get_tree().quit()
