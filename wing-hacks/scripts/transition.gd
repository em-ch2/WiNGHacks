extends CanvasLayer

@export var fade_time: float = 1.0
@onready var _overlay = $ColorRect # This looks for the child named ColorRect

func _ready():
	_overlay.modulate.a = 0.0
	_overlay.visible = false

func fade_out(callback: Callable) -> void:
	_overlay.visible = true
	_overlay.modulate.a = 0.0 # Ensure it starts at zero
	
	var tween = create_tween()
	# This line ensures the alpha goes to exactly 1.0 (full black)
	tween.tween_property(_overlay, "modulate:a", 1.0, fade_time)
	
	# This line forces Godot to wait until the fade is 100% done
	# before running the _change_scene function
	tween.tween_callback(callback)
