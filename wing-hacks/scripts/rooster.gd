extends CharacterBody2D

# Make sure these match the names in your Scene Tree exactly!
@onready var interaction_area = %Area2D
@onready var dialogue_ui = %DialogueUI
@onready var dialogue_label = %Label

var player_in_range = false
var dialogue_text = "Are you the dumpling merchant?"

func _ready():
	# This part connects the "Range" logic
	if interaction_area:
		interaction_area.body_entered.connect(_on_body_entered)
		interaction_area.body_exited.connect(_on_body_exited)
	
	if dialogue_ui:
		dialogue_ui.visible = false

func _input(event):
	# Checks if player is close AND pressed Enter/Space
	if player_in_range and event.is_action_pressed("ui_accept"):
		show_dialogue()

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		if dialogue_ui:
			dialogue_ui.visible = false

func show_dialogue():
	if dialogue_label and dialogue_ui:
		dialogue_label.text = dialogue_text
		dialogue_ui.visible = true
