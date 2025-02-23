extends Label

## Total Seconds
@export var timer: float = 60.00;

## Says if it already triggered \n [10, 60]
var secondsLeft: Array[bool] = [false, false];
signal ten_seconds_left;
signal sixty_seconds_left;


func _process(delta: float) -> void:
	timer -= delta;
	if (timer < 10 and not secondsLeft[0]):
		ten_seconds_left.emit();
		secondsLeft[0] = true;
	else: if (timer < 60 and not secondsLeft[1]):
		sixty_seconds_left.emit();
		secondsLeft[1] = true;
	formatTime();


func formatTime() -> void:
	if (timer < 60):
		text = "%4.2f" % timer;
		return;
	var seconds: int = int(timer) % 60;
	var minutes: int = floor(timer) / 60;

	text = "%02d:%02d" % [minutes, seconds];
	return;
	
