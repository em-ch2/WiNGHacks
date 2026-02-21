extends CharacterBody2D
@onready var anim = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var last_dir := "down"

func _physics_process(delta: float) -> void:
	var dir = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		dir.x -= 1
	if Input.is_action_pressed("player_right"):
		dir.x += 1
	if Input.is_action_pressed("player_up_idle"):
		dir.y -= 1
	if Input.is_action_pressed("player_idle"):
		dir.y += 1
	
	velocity = dir.normalized() * SPEED
	move_and_slide()
	
	if velocity == Vector2.ZERO:
		match last_dir:
			"up":
				anim.play("player_up_idle")
			"down":
				anim.play("player_idle")
			"left":
				anim.play("player_left_idle")
			"right":
				anim.play("player_right_idle")
	else:
		if (abs(velocity.x) > abs(velocity.y)):
			if(velocity.x > 0):
				anim.play("player_right")
				last_dir = "right"
			else:
				anim.play("player_left")
				last_dir = "left"
		else:
			if (velocity.y > 0):
				anim.play("player_idle")
				last_dir = "down"
			else:
				anim.play("player_up_idle")
				last_dir = "up"
