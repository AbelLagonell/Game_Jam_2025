extends Node

#text
var diaActive: bool = false;

#progession
var stage := 0; #Go up as timer alters/player progresses through days: 0, 1, 2.

#Stat Tracking
var _total_score: int 	= 0;
var chicken_inside: int= 0;
var sheep_inside: int 	= 0;
var cow_inside: int 	= 0;
var current_health: int	= 10;
var max_health: int 	= 10;

signal score_change(score: int);
signal health_change(health:int);
signal max_health_change(health:int);
signal cow_change(score:int);
signal chicken_change(score:int);
signal sheep_change(score:int);

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
	chicken_change.emit(cow_inside);

func modify_sheep(amount: int):
	sheep_inside += amount;
	sheep_change.emit(cow_inside);
	
func _ready() -> void:
	max_health_change.emit(max_health);
	reset();

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
	modify_health(current_health);
	stage = 0;
	

