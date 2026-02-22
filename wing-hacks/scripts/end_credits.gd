extends Control

# This path must match your tree: Background > Player
@onready var character = $Background/Player 

func _ready() -> void:
	character.play("dancing_1")

# Godot likely named this based on your 'Player' node name
func _on_player_animation_finished() -> void:
	if character.animation == "dancing_1":
		character.play("dancing_2")
	else:
		character.play("dancing_1")
