extends Node

@onready var player := AudioStreamPlayer.new()

func _ready():
	add_child(player)
	player.stream = preload("res://assets/Lotus Pond - Loop.wav")
	player.volume_db = -6
	player.play()
	
