extends Node

var time = 0
@onready var interaction_area: InteractionArea = $InteractionArea
@export var type: int = 0
@export var stage: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	check_type()
	check_stage()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_type()
	check_stage()
	$AnimatedSprite2D.play(str(type) + "_" + str(stage))
	grow()

func grow():
	if(time != global.stage):
		time = time + 1
		stage = stage + 1
		check_stage()

func check_stage():
	if(type < 0):
		type = 0
	if(type > 3):
		type = 3

func check_type():
	if(type < 0):
		type = 0
	if(type > 3):
		type = 3

func _on_interact():
	if(stage == 3 && !global.has_crop):
		global.has_crop = true
		print("Got crop type " + str(type))
		global.give_crop(type)
	else:
		print("It's not grown yet, bozo. Come back later.")
