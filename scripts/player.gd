class_name Player
extends CharacterBody3D

signal died

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	_process_movement_input(delta)
	_check_for_squash()

func _process_movement_input(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		basis = Basis.looking_at(direction)

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse

	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	velocity = target_velocity
	move_and_slide()

func _check_for_squash():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() == null:
			continue
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			# If hitting it from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.6:
				target_velocity.y = bounce_impulse
				mob.squash()
			else:
				_die()
			break

func _die():
	died.emit()
	hide()
