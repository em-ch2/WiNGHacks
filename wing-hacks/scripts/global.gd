extends Node

var current_scene = "world"
var last_world_scene = ""
var transition_scene = false


var minigame_success = false

var player_exit_palace_posx = 0
var player_exit_palace_posy = 0

var player_start_posx = 0
var player_start_posy = 0

var offered_dumplings = false
func start_dumplings_minigame() -> void:
	print("starting minigame")
	last_world_scene = get_tree().current_scene.scene_file_path

	get_tree().call_deferred("change_scene_to_file", "res://scene/minigame.tscn")
