class_name Spawner
extends Path3D

@export var prefab: PackedScene
@export var interval: float = 1
@export var spawn_root: Node

var spawn_location: PathFollow3D
var spawn_timer: Timer

func _ready():
	spawn_location = $SpawnLocation
	spawn_timer = $SpawnTimer
	spawn_timer.timeout.connect(_on_timer_timeout)
	start_spawn()
	
func clear():
	for child in spawn_root.get_children():
		child.queue_free()

func start_spawn():
	spawn_timer.start(interval)

func stop_spawn():
	spawn_timer.stop()

func spawn():
	var obj = prefab.instantiate()

	spawn_location.progress_ratio = randf()
	var spawn_pos = spawn_location.position

	init_spawned_object(obj, spawn_pos)

	spawn_root.add_child(obj)

# Child overrides this
func init_spawned_object(obj: Node3D, spawn_pos: Vector3):
	pass

func _on_timer_timeout():
	spawn()
