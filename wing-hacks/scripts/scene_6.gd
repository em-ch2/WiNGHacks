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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Change this line to point to 'transitions', NOT 'ColorRect'
		var transition = get_node("transitions") 
		transition.fade_out(Callable(self, "_change_scene"))
		
func _change_scene():
	get_tree().call_deferred("change_scene_to_file", "res://scene/horse.tscn")
		
