extends Node

var current_scene = "world"
var transition_scene = false

var player_exit_palace_posx = 0
var player_exit_palace_posy = 0

var player_start_posx = 0
var player_start_posy = 0

var offered_dumplings = false
func start_dumplings_minigame() -> void:
	print("starting minigame")
	get_tree().call_deferred("change_scene_to_file", "res://scene/minigame.tscn")
