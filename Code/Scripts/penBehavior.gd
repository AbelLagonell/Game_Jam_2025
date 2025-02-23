extends Area2D


func _on_body_shape_entered(_body_rid:RID, body:Node2D, _body_shape_index:int, _local_shape_index:int) -> void:
	if body.has_meta("Cow"):
		global.modify_cow(1);
	if body.has_meta("Sheep"):
		global.modify_sheep(1);
	if body.has_meta("Chicken"):
		global.modify_chicken(1);


func _on_body_shape_exited(_body_rid:RID, body:Node2D, _body_shape_index:int, _local_shape_index:int) -> void:
	if body.has_meta("Cow"):
		global.modify_cow(-1);
	if body.has_meta("Sheep"):
		global.modify_sheep(-1);
	if body.has_meta("Chicken"):
		global.modify_chicken(-1);
