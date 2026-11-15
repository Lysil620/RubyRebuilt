extends CharacterBody2D


const SPEED = 250

@export var jump_height : int = 196
@export var jump_time : int = 120
var jump_velocity : float = jump_height * 4.0 / (jump_time - 1) * 60
var gravity : float = jump_velocity * 2.0 / (jump_time - 1)
var frame_num = 0
var start_frame = 0

func _ready() -> void:
	print(jump_velocity)
	print(gravity * 60)

func _physics_process(delta: float) -> void:
	
	if is_on_floor() and start_frame:
		print("just started on " + str(start_frame) + "; enden on " + str(frame_num) + "; lasting " + str(frame_num - start_frame))
		start_frame = 0

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_velocity - gravity * 0.5
		start_frame = frame_num
	if abs(velocity.y) <= 9.0 and not is_on_floor():
		print(592 - position.y)
	velocity.y += gravity
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	frame_num += 1
