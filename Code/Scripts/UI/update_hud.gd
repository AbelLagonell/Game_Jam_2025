@tool
extends Node

@export var healthbar: ProgressBar;
@export var score_tracker: Label;

func _ready() -> void:
	if (healthbar != null):
		global.max_health_change.connect(_change_max);
		global.health_change.connect(_change_health);
		healthbar.max_value = global.max_health;
		healthbar.value = global.current_health;
	if (score_tracker != null):
		global.score_change.connect(_change_score.bind(global))
	
func _change_max(max_value:int):
	healthbar.max_value = max_value;

func _change_health(health:int):
	healthbar.value = health;
	
func _change_score(score:int):
	score_tracker.text = "%5d" % score;
