extends CharacterBody2D

@export var dialogue_resource : DialogueResource
@export var start_node : String = "start"

var player_in_range = false

# Make sure your Area2D is named RoosterArea
@onready var area = $RoosterArea

func _ready():
	# Connect signals only once
	area.body_entered.connect(_on_area_body_entered)
	area.body_exited.connect(_on_area_body_exited)

func _on_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):   # or body.name == "Player"
		player_in_range = true
		print("Player entered rooster area!")

func _on_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):   # or body.name == "Player"
		player_in_range = false
		print("Player left rooster area!")

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		print("Interacting with rooster")
		DialogueManager.show_dialogue_balloon(dialogue_resource, start_node)
