extends Node

var active_food : String = "Nothing"

var foods : Array[String] = ["baguette", "coffee", "croissant"]

var random_food : int = randi_range(0, 2)

var beaguette_recipe : Array[String] = ["Mix Wheat, Water, Salt, and Yeast in a bowl", "Bake in oven"]

func _ready() -> void:
	print(random_food)
	active_food = foods[random_food]
	print(active_food)
