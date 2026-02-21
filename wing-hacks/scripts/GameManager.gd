extends Node

var dumpling_ingredients = ["Soy Sauce", "Shrimp", "Celery"]
func get_ingredients() -> String:
	var ingredients = dumpling_ingredients.duplicate()
	ingredients.shuffle()
	
	var count = randi_range(1,3)
	var selected = ingredients.slice(0,count)
	
	return ",".join(selected)
