extends Node

# Path to the sprite that will change
@onready var dumpling_sprite = $Base
var required_ingredients = ""
var is_ruined = false
var is_finishing = false


# Preload all your combination images
var img_empty = preload("res://assets/Dumpling.jpeg")
var img_celery = preload("res://assets/Celery.jpeg")
var img_shrimp = preload("res://assets/Shrimp.jpeg")
var img_soy = preload("res://assets/SoySauce.jpeg")
var img_celery_shrimp = preload("res://assets/Celery_Shrimp.jpeg")
var img_celery_soy = preload("res://assets/SoySauce_Celery.jpeg")
var img_shrimp_soy = preload("res://assets/Shrimp_SoySauce.jpeg")
var img_finished = preload("res://assets/DumplingFinished.jpeg")
var img_everything = preload("res://assets/Everything.jpeg")

# Track what the player has tapped
var has_celery = false
var has_shrimp = false
var has_soy = false

func _ready():
	# Reset the plate to empty when the minigame starts
	required_ingredients = GameManager.current_order
	dumpling_sprite.texture = img_empty
	has_celery = false
	has_shrimp = false
	has_soy = false

# --- SIGNAL FUNCTIONS ---

func _on_celery_btn_pressed() -> void:
	if "Celery" not in required_ingredients:
		is_ruined = true
	has_celery = true
	print("Pressed CELERY →", has_celery, has_shrimp, has_soy)
	update_dumpling_appearance()
	play_tap_effect()

func _on_shrimp_btn_pressed() -> void:
	if "Shrimp" not in required_ingredients:
		is_ruined = true
	has_shrimp = true
	print("Pressed SHRIMP →", has_celery, has_shrimp, has_soy)
	update_dumpling_appearance()
	play_tap_effect()

func _on_soy_sauce_2_pressed() -> void:
	if "Soy Sauce" not in required_ingredients:
		is_ruined = true
	has_soy = true
	update_dumpling_appearance()
	print("Pressed SOY →", has_celery, has_shrimp, has_soy)
	play_tap_effect()

# --- LOGIC FUNCTIONS ---

func update_dumpling_appearance() -> void:
	if is_finishing:
		return
	
	# This checks combinations to decide which image to show
	if has_celery and has_shrimp and has_soy:
		dumpling_sprite.texture = img_everything
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	elif has_shrimp and has_soy:
		dumpling_sprite.texture = img_shrimp_soy
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	elif has_celery and has_shrimp:
		dumpling_sprite.texture = img_celery_shrimp
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	elif has_celery and has_soy:
		dumpling_sprite.texture = img_celery_soy
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	elif has_celery:
		dumpling_sprite.texture = img_celery
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	elif has_shrimp:
		dumpling_sprite.texture = img_shrimp
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	elif has_soy:
		dumpling_sprite.texture = img_soy
		dumpling_sprite.scale = Vector2(0.5, 0.5)
	
	if is_ruined:
		dumpling_sprite.texture = img_finished
		dumpling_sprite.scale = Vector2(0.5, 0.5)	
		
	var current_recipe = []
	if has_celery: current_recipe.append("Celery")
	if has_shrimp: current_recipe.append("Shrimp")
	if has_soy: current_recipe.append("Soy Sauce")
	if check_recipe_complete(current_recipe) and not is_ruined:
		dumpling_sprite.texture = img_finished
		is_finishing = true
		complete_minigame(true)
	elif is_ruined:
		dumpling_sprite.texture = img_finished
		is_finishing = true
		complete_minigame(false)
		
func check_recipe_complete(current_list: Array) -> bool:
	var req_array = required_ingredients.split(",")
	for item in req_array:
		if item not in current_list:
			return false
	return true
	

func play_tap_effect() -> void:
	var tween = create_tween()
	tween.tween_property(dumpling_sprite, "scale", Vector2(0.4, 0.4), 0.05)
	tween.tween_property(dumpling_sprite, "scale", Vector2(0.4, 0.4), 0.05)

func complete_minigame(success: bool) -> void:
	Global.minigame_success = success
	await get_tree().create_timer(1.5).timeout
	Global.offered_dumplings = true
	if Global.last_world_scene != "":
		get_tree().change_scene_to_file(Global.last_world_scene)
	else:
		get_tree().change_scene_to_file("res://scene/world.tscn")
