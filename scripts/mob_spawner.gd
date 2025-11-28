class_name MobSpawner
extends Spawner

signal mob_spawn

@export var target: Node3D

func init_spawned_object(obj: Node3D, spawn_pos: Vector3):
	obj.init(spawn_pos, target)
	# obj.rotate_y(randf_range(-PI/4, PI/4))
	mob_spawn.emit(obj)
