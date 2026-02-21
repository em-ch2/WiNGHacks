extends Node

@onready var player := AudioStreamPlayer.new()

func _ready():
	add_child(player)
	Music.player.stream = preload("res://assets/Lotus Pond - Loop.wav")
	Music.player.volume_db = -6
	Music.player.play()
