extends Area2D

func _on_body_shape_entered(body_rid:RID, body:Node2D, body_shape_index:int, local_shape_index:int) -> void:
	if (!body.has_method("enemy")): return
	match body.enemyType:
		"Cow": 
			global.modify_cow(1)
		"Sheep": 
			global.modify_sheep(1)
		"Chicken": 
			global.modify_chicken(1)

func _on_body_shape_exited(body_rid:RID, body:Node2D, body_shape_index:int, local_shape_index:int) -> void:
	if (!body.has_method("enemy")): return
	match body.enemyType: 
		"Cow": 
			global.modify_cow(-1)
		"Sheep": 
			global.modify_sheep(-1)
		"Chicken": 
			global.modify_chicken(-1)
