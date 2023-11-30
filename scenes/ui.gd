extends CanvasLayer

func _ready():
	Globals.connect("score", update_score_text)

func update_score_text():
	$LeftScore.text = str(Globals.left_player_score)
	$RightScore.text = str(Globals.right_player_score)
	$ScoreSound.play()
