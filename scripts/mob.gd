class_name Mob
extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 18

func init(spawn_pos, target) -> void:
	if not is_instance_valid(target):
		position = spawn_pos
		return
	look_at_from_position(spawn_pos, target.position, Vector3.UP)
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _physics_process(_delta):
	move_and_slide()

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

func squash():
	squashed.emit(self)
	queue_free()
