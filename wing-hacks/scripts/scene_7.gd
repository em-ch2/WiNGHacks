extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $Player
	var camera = player.get_node("player/Camera2D")
	var tilemap = $TileMapLayer
	
	var used_rect = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size
	
	var map_pixel_size = used_rect.size * tile_size
	var map_pixel_position = used_rect.position * tile_size
	
	camera.limit_left = map_pixel_position.x
	camera.limit_top = map_pixel_position.y
	camera.limit_right = map_pixel_position.x + map_pixel_size.x
	camera.limit_bottom = map_pixel_position.y + map_pixel_size.y
	
	Music.player.stream = preload("res://assets/Dragon Dance - Loop.wav")
	Music.player.volume_db = -6
	Music.player.play()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/horse.dialogue"), "start")
		return
	if Input.is_action_just_pressed("narrator"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/Scene7.dialogue"), "start")
		return
