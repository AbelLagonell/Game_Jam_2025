extends Node

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
	$AnimatedSprite2D.play(str(type) + "_" + str(stage))
	check_type()
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
	if(stage == 3):
		print("Got crop type " + str(type))
	else:
		print("It's not grown yet, bozo. Come back later.")
