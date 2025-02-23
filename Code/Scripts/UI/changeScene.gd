extends Button

@export var scene_key: String = "";

func _on_pressed() -> void:
	SceneManager.switch_scene(scene_key);
	if (scene_key == "Menu"):
		global.reset();
