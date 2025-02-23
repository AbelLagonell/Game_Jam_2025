extends Node
class_name NSceneManager


@export var Scenes : Dictionary= {};

signal paused()

var m_CurrentSenceAlias : String = "";

func get_scenes() -> Array:
	return Scenes.keys()

func add_scene(scene_alias: StringName, scene_path: StringName) -> void:
	Scenes[scene_alias] = scene_path;

func remove_scene(scene_alias: String) -> void:
	Scenes.erase(scene_alias);

func switch_scene(scene_alias: String) -> void:
	get_tree().change_scene_to_file(Scenes[scene_alias]); 

func restart_scene() -> void:
	get_tree().reload_current_scene();

func quit_game() -> void:
	get_tree().quit()
	
func toggle_pause() -> void:
	paused.emit();
	get_tree().paused = !get_tree().paused