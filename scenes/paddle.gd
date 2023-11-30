extends CharacterBody2D

# players 0 and 1 are human, player 2 is ai
#player numbers 0 and 1 are human, 2 is ai
# 0 uses up and down arrows, 1 uses w and s
const speed: int = 300
var player_number: int = 0

# TODO: make ai beatable:
# Probably solution: instead of always following the ball when it's coming its way
# the ai tries to calculate where it will reach
# and it moves to that position BUT with some random offset, so it can miss sometimes

#for ai
var desired_height: float = 150
var target_height: float = 150
var damping = 0.1
var random_error: float


func _ready():
	#if we just score, reset the error to zero to make the ai not fall into an abusable loop
	Globals.connect("score", reset_error)
	if Globals.ball_velocity.x < 0:
		target_height = Globals.ball_pos.y + Globals.ball_velocity.y * (10 - Globals.ball_pos.x)/Globals.ball_velocity.x


func _process(_delta):
	var direction: Vector2 = Vector2.ZERO
	if player_number == 0:
		if Input.is_action_pressed("up"):
			direction.y -= 1
		if Input.is_action_pressed("down"):
			direction.y += 1
	
	elif player_number == 1:
		if Input.is_action_pressed("up2"):
			direction.y -= 1
		if Input.is_action_pressed("down2"):
			direction.y += 1
	# ai
	else:
		if Globals.ball_velocity.x >= 0:
			target_height = 150
		else:
			target_height = Globals.ball_pos.y + Globals.ball_velocity.y * (10 - Globals.ball_pos.x)/Globals.ball_velocity.x + random_error
		desired_height = lerp(position.y, target_height, damping)
		direction.y = clamp(desired_height - position.y, -1, 1)

	velocity = direction * speed
	move_and_slide()


# we add a random error to make the ai beatable
func _on_ball_just_collided():
	random_error = randf_range(-45, 45)

func reset_error():
	random_error = 0
