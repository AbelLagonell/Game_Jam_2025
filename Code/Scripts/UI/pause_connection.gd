extends CanvasLayer

func _ready() -> void:
	SceneManager.paused.connect(toggle_visibility)
	
func toggle_visibility():
	visible = !visible

func _on_back_pressed() -> void:
	SceneManager.toggle_pause();
