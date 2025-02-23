extends Node

#text
var diaActive: bool = false;

#progession
var stage :int = 0; #Go up as timer alters/player progresses through days: 0, 1, 2.

#Stat Tracking
var _total_score: int 	= 0;
var chicken_inside: int = 0;
var sheep_inside: int 	= 0;
var cow_inside: int 	= 0;
var current_health: int	= 10;
var max_health: int 	= 10;
var timeout := false;


signal score_change(score: int);
signal health_change(health:int);
signal max_health_change(health:int);
signal cow_change(score:int);
signal chicken_change(score:int);
signal sheep_change(score:int);
signal game_end();


func _ready() -> void:
	max_health_change.emit(max_health);
	reset();

func stop_game():
	get_tree().paused=true
	game_end.emit();
	

func get_score()->int:
	var count := 0;
	if (cow_inside > 0):
		count+=1;
		_total_score += cow_inside;
	if (chicken_inside > 0):
		count+=1;
		_total_score += chicken_inside;
	if (sheep_inside > 0):
		count+=1;
		_total_score += sheep_inside;
	return _total_score + (count-1)*5	

func modify_stage():
	stage += 1;

func modify_score(score: int):
	_total_score += score;
	score_change.emit(_total_score);

func modify_health(n: int):
	current_health += n;
	health_change.emit(current_health);
	
func set_max_health(health:int):
	max_health = health;
	max_health_change.emit(health);

func modify_cow(amount: int):
	cow_inside += amount;
	cow_change.emit(cow_inside);

func modify_chicken(amount: int):
	chicken_inside += amount;
	chicken_change.emit(chicken_inside);

func modify_sheep(amount: int):
	sheep_inside += amount;
	sheep_change.emit(sheep_inside);
	

#crop management
var has_crop: bool = false;
var crop_type = 0
func give_crop(type):
	crop_type = type
	has_crop = true

func reset():
	_total_score = 0;
	modify_score(_total_score);
	chicken_inside =0;
	modify_chicken(chicken_inside);
	sheep_inside = 0;
	modify_sheep(sheep_inside);
	cow_inside = 0;
	modify_cow(cow_inside);
	current_health = max_health;
	modify_health(0);
	stage = 0;
