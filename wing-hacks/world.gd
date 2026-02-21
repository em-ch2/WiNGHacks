extends Node
var PigScene = preload("res://scenes/pig_scene.tscn")
var RoosterSheepScene = preload("res://scenes/rooster_sheep_scene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pig_instance = PigScene.instantiate()
	add_child(pig_instance)
	var rooster_sheep_instance = RoosterSheepScene.instantiate()
	add_child(rooster_sheep_instance)
