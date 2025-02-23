@tool
extends Node

@export var healthbar: ProgressBar;
@export var score_tracker: Label;
@export var chicken_score: Label;
@export var cow_score: Label;
@export var sheep_score: Label;
@export var canvas: CanvasModulate;
@export var time_tracker: Label;
@export var duration : float = 10;

const NIGHT_COLOR := Color("#091d3a");
const DAY_COLOR := Color("#FFF");

var time: float = 0.00;
var reset_timer: float = 0;
var night := false;

func _physics_process(delta: float) -> void:
	time += delta;
	reset_timer = int(time);
	if (canvas != null): 
		canvas.set_color(NIGHT_COLOR.lerp(DAY_COLOR, abs(sin(time *  PI/(2 * duration)))));
	if (reset_timer > duration*4):
		reset_timer = 0;
		night = false;
	if (reset_timer == duration*1.5 and not night):
		night = true;
		global.stage += 1;
	formatTime();


func formatTime() -> void:
	if (time < 60):
		time_tracker.text = "%4.2f" % time;
		return;
	var seconds: int = int(time) % 60;
	var minutes: int = floor(time) / 60;

	time_tracker.text = "%02d:%02d" % [minutes, seconds];
	return;


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
