extends Node

# Path to the sprite that will change
@onready var dumpling_sprite = $Base

# Preload all your combination images
var img_empty = preload("res://assets/Dumpling.jpeg")
var img_celery = preload("res://assets/Celery.jpeg")
var img_shrimp = preload("res://assets/Shrimp.jpeg")
var img_soy = preload("res://assets/SoySauce.jpeg")
var img_celery_shrimp = preload("res://assets/Celery_Shrimp.jpeg")
var img_celery_soy = preload("res://assets/SoySauce_Celery.jpeg")
var img_shrimp_soy = preload("res://assets/Shrimp_SoySauce.jpeg")
var img_finished = preload("res://assets/DumplingFinished.jpeg")

# Track what the player has tapped
var has_celery = false
var has_shrimp = false
var has_soy = false

func _ready():
	# Reset the plate to empty when the minigame starts
	dumpling_sprite.texture = img_empty
	has_celery = false
	has_shrimp = false
	has_soy = false

# --- SIGNAL FUNCTIONS ---

func _on_celery_btn_pressed() -> void:
	has_celery = true
	update_dumpling_appearance()
	play_tap_effect()

func _on_shrimp_btn_pressed() -> void:
	has_shrimp = true
	update_dumpling_appearance()
	play_tap_effect()

func _on_soy_sauce_2_pressed() -> void:
	has_soy = true
	update_dumpling_appearance()
	play_tap_effect()

# --- LOGIC FUNCTIONS ---

func update_dumpling_appearance() -> void:
	# This checks combinations to decide which image to show
	if has_celery and has_shrimp and has_soy:
		dumpling_sprite.texture = img_finished
		dumpling_sprite.scale = Vector2(0.2, 0.2)
		complete_minigame()
	elif has_celery and has_shrimp:
		dumpling_sprite.texture = img_celery_shrimp
		dumpling_sprite.scale = Vector2(0.2, 0.2)
	elif has_celery and has_soy:
		dumpling_sprite.texture = img_celery_soy
		dumpling_sprite.scale = Vector2(0.2, 0.2)
	elif has_shrimp and has_soy:
		dumpling_sprite.texture = img_shrimp_soy
		dumpling_sprite.scale = Vector2(0.2, 0.2)
	elif has_celery:
		dumpling_sprite.texture = img_celery
		dumpling_sprite.scale = Vector2(0.2, 0.2)
	elif has_shrimp:
		dumpling_sprite.texture = img_shrimp
		dumpling_sprite.scale = Vector2(0.2, 0.2)
	elif has_soy:
		dumpling_sprite.texture = img_soy
		dumpling_sprite.scale = Vector2(0.2, 0.2)
	

func play_tap_effect() -> void:
	var tween = create_tween()
	tween.tween_property(dumpling_sprite, "scale", Vector2(0.2, 0.2), 0.05)
	tween.tween_property(dumpling_sprite, "scale", Vector2(0.2, 0.2), 0.05)

func complete_minigame() -> void:
	await get_tree().create_timer(1.5).timeout
	Global.offered_dumplings = true
	get_tree().change_scene_to_file("res://scene/rooster_sheep.tscn")
