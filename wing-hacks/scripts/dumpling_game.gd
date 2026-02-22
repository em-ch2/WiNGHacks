extends Node

@onready var dumpling_sprite = $Base

var required_ingredients: Array = []
var added_ingredients: Array = []

var is_ruined = false
var is_finishing = false

# Preload images
var img_empty = preload("res://assets/Dumpling.jpeg")
var img_celery = preload("res://assets/Celery.jpeg")
var img_shrimp = preload("res://assets/Shrimp.jpeg")
var img_soy = preload("res://assets/SoySauce.jpeg")
var img_celery_shrimp = preload("res://assets/Celery_Shrimp.jpeg")
var img_celery_soy = preload("res://assets/SoySauce_Celery.jpeg")
var img_shrimp_soy = preload("res://assets/Shrimp_SoySauce.jpeg")
var img_finished = preload("res://assets/DumplingFinished.jpeg")
var img_everything = preload("res://assets/Everything.jpeg")

func _ready():
	dumpling_sprite.scale = Vector2(0.3, 0.3)
	required_ingredients = GameManager.current_order.split(",")
	added_ingredients.clear()
	dumpling_sprite.texture = img_empty
	is_ruined = false
	is_finishing = false

# --- BUTTON SIGNALS ---

func _on_celery_btn_pressed():
	handle_ingredient("Celery")

func _on_shrimp_btn_pressed():
	handle_ingredient("Shrimp")

func _on_soy_sauce_2_pressed():
	handle_ingredient("Soy Sauce")

# --- CORE INGREDIENT HANDLER ---

func handle_ingredient(item: String) -> void:
	if is_finishing:
		return

	# Check if this ingredient is expected next
	var next_required = required_ingredients[added_ingredients.size()] if added_ingredients.size() < required_ingredients.size() else null

	if item != next_required:
		is_ruined = true

	added_ingredients.append(item)
	update_dumpling_appearance()
	play_tap_effect()

# --- APPEARANCE LOGIC ---

func update_dumpling_appearance() -> void:
	if is_finishing:
		return

	# Visual combinations
	var has_celery = "Celery" in added_ingredients
	var has_shrimp = "Shrimp" in added_ingredients
	var has_soy = "Soy Sauce" in added_ingredients

	if has_celery and has_shrimp and has_soy:
		dumpling_sprite.texture = img_everything
		dumpling_sprite.scale = Vector2(0.35, 0.35)
	elif has_shrimp and has_soy:
		dumpling_sprite.texture = img_shrimp_soy
		dumpling_sprite.scale = Vector2(0.35, 0.35)
	elif has_celery and has_shrimp:
		dumpling_sprite.texture = img_celery_shrimp
		dumpling_sprite.scale = Vector2(0.35, 0.35)
	elif has_celery and has_soy:
		dumpling_sprite.texture = img_celery_soy
		dumpling_sprite.scale = Vector2(0.35, 0.35)
	elif has_celery:
		dumpling_sprite.texture = img_celery
		dumpling_sprite.scale = Vector2(0.35, 0.35)
	elif has_shrimp:
		dumpling_sprite.texture = img_shrimp
		dumpling_sprite.scale = Vector2(0.35, 0.35)
	elif has_soy:
		dumpling_sprite.texture = img_soy
		dumpling_sprite.scale = Vector2(0.35, 0.35)



# --- EFFECTS & FINISHING ---

func play_tap_effect() -> void:
	var tween = create_tween()

	# Step 1: grow slightly
	tween.tween_property(dumpling_sprite, "scale", Vector2(0.48, 0.48), 0.06)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

	# Step 2: return to normal size
	tween.tween_property(dumpling_sprite, "scale", Vector2(0.35, 0.35), 0.08)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN)
	dumpling_sprite.scale = Vector2(0.35, 0.35)
func complete_minigame(success: bool) -> void:
	Global.minigame_success = success
	await get_tree().create_timer(1.5).timeout
	Global.offered_dumplings = true

	if Global.last_world_scene != "":
		get_tree().change_scene_to_file(Global.last_world_scene)
	else:
		get_tree().change_scene_to_file("res://scene/world.tscn")
		
		
func _on_finish_pressed():
	if is_finishing:
		return

	var correct = true

	# Check for extra ingredients
	if added_ingredients.size() != required_ingredients.size():
		correct = false

	# Check order
	for i in range(min(added_ingredients.size(), required_ingredients.size())):
		if added_ingredients[i] != required_ingredients[i]:
			correct = false
			break

	is_finishing = true
	dumpling_sprite.texture = img_finished

	complete_minigame(correct)


func _on_finish_button_up() -> void:
	pass # Replace with function body.
