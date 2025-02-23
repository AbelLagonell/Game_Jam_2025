@tool
extends Node

@export var healthbar: ProgressBar;
@export var score_tracker: Label;
@export var chicken_score: Label;
@export var cow_score: Label;
@export var sheep_score: Label;

func _ready() -> void:
	if (healthbar != null):
		global.max_health_change.connect(_change_max);
		global.health_change.connect(_change_health);
		healthbar.max_value = global.max_health;
		healthbar.value = global.current_health;
	if (score_tracker != null):
		global.score_change.connect(_change_score)
	if (chicken_score != null):
		global.chicken_change.connect(_change_chicken)
	if (sheep_score != null):
		global.sheep_change.connect(_change_sheep)
	if (cow_score != null):
		global.cow_change.connect(_change_cow)
		
	
func _change_max(max_value:int):
	healthbar.max_value = max_value;

func _change_health(health:int):
	healthbar.value = health;
	
func _change_score(score:int):
	score_tracker.text = "%5d" % score;
	
func _change_chicken(score:int):
	chicken_score.text = "%3d" % score;

func _change_sheep(score:int):
	sheep_score.text = "%3d" % score;

func _change_cow(score:int):
	cow_score.text = "%3d" % score;
