extends Control

@onready var instructions_popup = $AcceptDialog
@onready var anim_player = $fade_in # Or whatever your AnimationPlayer is named

func _ready() -> void:
	# Ensure it's hidden when we start
	instructions_popup.hide() 
	# The fade_in animation should be set to "Autoplay" in the AnimationPlayer panel
	pass

func _on_start_button_pressed():
	# Only change scenes here
	get_tree().change_scene_to_file("res://scene/world.tscn")

func _on_instruction_button_pressed():
	# Only show the popup when THIS specific button is clicked
	instructions_popup.popup_centered()
	
@onready var horse = $Background/Horse
var speed = 150 # Pixels per second

func _process(delta):
	horse.position.x -= speed * delta
	var screen_width = get_viewport_rect().size.x
	
	if horse.position.x < -200:
		horse.position.x = screen_width + 200
	
