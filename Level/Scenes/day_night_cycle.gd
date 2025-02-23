class_name DayNightCycle
extends CanvasModulate


const NIGHT_COLOR := Color("#091d3a");
const DAY_COLOR := Color("#FFF");


func change_color(time):
	self.color = NIGHT_COLOR.lerp(DAY_COLOR, abs(cos(time * TIME_SCALE)));