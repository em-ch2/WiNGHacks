extends CanvasLayer

func _ready():
	# This runs the second the scene starts
	show_save_icon()

func show_save_icon():
	$Control.visible = true
	$AnimationPlayer.play("save_loop") 
	
	await get_tree().create_timer(2.0).timeout
	hide_save_icon()

func hide_save_icon():
	$Control.visible = false
	$AnimationPlayer.stop()
