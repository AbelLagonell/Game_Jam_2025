@tool
extends Node

@export var healthbar: ProgressBar;
@export var score_tracker: Label;
@export var chicken_score: Label;
@export var cow_score: Label;
@export var sheep_score: Label;
@export var canvas: CanvasModulate;
@export var time_tracker: Label;
@export var duration : int = 10;

const NIGHT_COLOR := Color("#091d3a");
const DAWN_DUSK_COLOR := Color("#F72")
const DAY_COLOR := Color("#FFF");

var time: float = 0.00;
var reset_timer: int = 0;
var trigger := false;

func _physics_process(delta: float) -> void: 
	if Engine.is_editor_hint():
		return	
	
	time += delta;
	reset_timer = int(time) % (duration*2+1);
	if (canvas != null):
		var normalized_time = time / float(duration * 2)
		normalized_time = fmod(normalized_time, 1.0)

		if normalized_time < 0.25:  # Night to Dawn
			var t = smoothstep(0.0, 0.25, normalized_time)
			canvas.set_color(NIGHT_COLOR.lerp(DAWN_DUSK_COLOR, t))
		elif normalized_time < 0.5:  # Dawn to Day
			var t = smoothstep(0.25, 0.5, normalized_time)
			canvas.set_color(DAWN_DUSK_COLOR.lerp(DAY_COLOR, t))
		elif normalized_time < 0.75:  # Day to Dusk
			var t = smoothstep(0.5, 0.75, normalized_time)
			canvas.set_color(DAY_COLOR.lerp(DAWN_DUSK_COLOR, t))
		else:  # Dusk to Night
			var t = smoothstep(0.75, 1.0, normalized_time)
			canvas.set_color(DAWN_DUSK_COLOR.lerp(NIGHT_COLOR, t))
	if (trigger && reset_timer < duration):
		trigger = false;
	if (reset_timer == duration*2 and not trigger):
		trigger = true;
		global.stage += 1;
	formatTime();
	if (time > 90):
		global.stop_game()


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
