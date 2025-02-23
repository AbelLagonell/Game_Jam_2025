extends Label

## Total Seconds
var timer: float = 0.00;


func _process(delta: float) -> void:
	timer += delta;
	formatTime();


func formatTime() -> void:
	if (timer < 60):
		text = "%4.2f" % timer;
		return;
	var seconds: int = int(timer) % 60;
	var minutes: int = floor(timer) / 60;

	text = "%02d:%02d" % [minutes, seconds];
	return;
	