extends Node

var dumpling_ingredients = ["Soy Sauce", "Shrimp", "Celery"]
var current_order = ""
func get_ingredients() -> String:
	var ingredients = dumpling_ingredients.duplicate()
	ingredients.shuffle()
	
	var count = randi_range(1,3)
	var selected = ingredients.slice(0,count)
	
	current_order = ",".join(selected)
	return current_order
