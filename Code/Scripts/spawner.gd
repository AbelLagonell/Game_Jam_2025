extends Node

var sheep = preload("res://Level/Prefabs/characters/sheep.tscn")
var cow = preload("res://Level/Prefabs/characters/cow.tscn")
var chicken = preload("res://Level/Prefabs/characters/chicken.tscn")

var rng = RandomNumberGenerator.new()

@export var type: int = 0 #0 is sheep, 1 is cow, 2 is chicken

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnAnimal():
	var instance = sheep.instantiate()
	if(type == 0):
		instance = sheep.instantiate()
		instance.startX = self.position.x
		instance.startY = self.position.y
		add_sibling(instance)
	if(type == 1):
		instance = cow.instantiate()
		add_sibling(instance)
	if(type == 2):
		instance = chicken.instantiate()
		add_sibling(instance)

func _on_timer_timeout() -> void:
	spawnAnimal()
