extends Node3D

var score = 0
var mob_spawner: MobSpawner;
var game_over_ui: Control;
var text_score: Label;
var player: Player;
var init_position: Vector3;
var music_player: AudioStreamPlayer3D;

func _ready() -> void:
	mob_spawner = $MobSpawner
	game_over_ui = $HUD/GameOver
	text_score = $HUD/TextScore
	player = $Player
	music_player = $MusicPlayer
	init_position = player.position
	new_game()
	
func new_game():
	score = 0
	player.position = init_position
	player.show()
	game_over_ui.hide()
	mob_spawner.clear()
	mob_spawner.start_spawn()
	music_player.play()

func game_over():
	mob_spawner.stop_spawn()
	game_over_ui.show()
	music_player.stop()

func _set_score(value):
	score = value
	text_score.text = "Score: %d" % score

func _on_player_died():
	game_over()

func _on_button_retry_pressed():
	new_game()

func _on_mob_spawner_mob_spawn(mob: Mob):
	mob.squashed.connect(_on_mob_squashed)
	
func _on_mob_squashed(_mob: Mob):
	_set_score(score + 1) # Replace with function body.
