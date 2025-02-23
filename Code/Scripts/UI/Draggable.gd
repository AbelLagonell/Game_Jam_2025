extends Node2D
class_name Draggable

var dragging = false;
var offset = Vector2(0,0)

func _process(delta):
	if(dragging):
		position = get_global_mouse_position() - offset

func _on_draggable_button_up():
	dragging = false

func _on_draggable_button_down():
	dragging = true
	offset = get_global_mouse_position() - global_position
