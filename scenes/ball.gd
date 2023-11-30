extends RigidBody2D


var speed: int = 350
var direction: Vector2 = Vector2(1, 0)
var velocity: Vector2

signal just_collided

func _ready():
	Globals.connect("score", return_to_center)
	
	return_to_center()
	


func _physics_process(delta):
	var collision =  move_and_collide(velocity * delta)
	if collision:
		just_collided.emit()
		$HitSound.play()
		# if it's a paddle, change direction relative to distance from center
		# at center: normal vector from paddle
		# different from center: an angle from -45° to 45° depending on the distance
		#Maximum distance they can collide at is 25 + 10 (half paddle height +ball height)
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		if collider.is_in_group("Paddles") and normal.x != 0:
			var distance = position.y - collider.global_position.y
			velocity = speed * normal.rotated(-PI/4 * distance/35)
			if normal.x == 1:
				velocity.y *= -1
		# if it's simply a wall just bounce normally
		else:
			velocity = velocity.bounce(normal)
	
	# update global ball position
	Globals.ball_pos = position
	Globals.ball_velocity = velocity

func return_to_center():
	position = Vector2(270, 150)
	direction = random_start_direction()
	
	velocity = Vector2.ZERO
	await get_tree().create_timer(0.5).timeout
	velocity = direction * speed

func random_start_direction():
	var dir = Vector2.ZERO
	dir.x = [1, -1].pick_random()
	dir = dir.rotated(randf_range(-PI/4, PI/4))
	return dir
