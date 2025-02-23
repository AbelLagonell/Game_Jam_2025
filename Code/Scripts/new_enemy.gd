extends CharacterBody2D
class_name NewEnemy

var rng = RandomNumberGenerator.new()

var targetPosition : Vector2 = global_position;
var target: Node2D = null;

var isDetected : bool = false;
var isWalking: bool = false;
var isAttacking: bool = false;
var isHeld: bool = false;
var isInvincible: bool =false;

var gStage : int = 0;
var stage: int = 0;
var health: int = 0;

@onready var hitbox: Area2D = $enemy_hitbox;
@onready var interactionArea : InteractionArea = $InteractionArea;

@export var hurtbox : CollisionShape2D = null;
@export var start := Vector2(0,0);
@export var speed := 10;
@export_enum("Cow","Sheep", "Chicken") var enemyType : String = "";



func enemy():
	pass


func _ready() -> void:
	position = start;
	updateTargetPos();
	interactionArea.interact = Callable(self, "_on_interact");

func _physics_process(delta: float) -> void:
	updateForm();	
	
	if (isHeld):
		position = get_global_mouse_position();
		start = position;
		targetPosition = start;
		isWalking = false;
		animate()
		return;
	
	animate();
	if stage != 2 or not isAttacking:
		wander;
		hitbox.get_child(0).set_disabled(true);
	# We want to attack the other thing that comes close;
	position = position.lerp(target.position, delta * speed);
	$AnimatedSprite2D.play("2_atk")
	hitbox.get_child(0).set_disabled(false);
	if(target.position.x - position.x) < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func updateTargetPos():
	rng.randomize()
	var targetVec: Vector2 = Vector2(rng.randf_range(-32,32), rng.randf_range(-32,32))
	targetPosition = start + targetVec

func wander():
	if(position == targetPosition):
		isWalking = false;
	else:
		position += (targetPosition - position)/speed
		isWalking = true;
		if(targetPosition - position) < Vector2(0,0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

func _on_interact():
	if global.has_crop == true:
		stage = stage - 1
		global.crop_type = 0
		global.has_crop = false
		
func animate():
	if(isWalking):
		if(stage == 0):
			$AnimatedSprite2D.play("0_walk")
		if(stage == 1):
			$AnimatedSprite2D.play("1_walk")
		if(stage == 2):
			$AnimatedSprite2D.play("2_walk")
	if(!isWalking):
		if(stage == 0):
			$AnimatedSprite2D.play("0_idle")
		if(stage == 1):
			$AnimatedSprite2D.play("1_idle")
		if(stage == 2):
			$AnimatedSprite2D.play("2_idle")

func updateForm():
	if(gStage != global.stage): #if the stage count changes, add 1
		gStage = global.stage
		stage = stage + 1
		if(stage == 0):
			pass #Sound effect of transforming into base form.
		if(stage == 1):
			pass #sound effect of transforming into 2nd form.
		if(stage == 2):
			pass #sound effect of transforming fully.

	#Check to make sure stage hasn't gone over/under
	if(stage > 3):
		stage = 3
	if(stage < 0):
		stage = 0

func _on_detection_area_body_entered(body):
	if body.enemyType == self.enemyType: return;
	if body.has_method("player") or body.has_method("animal"):
		#Need to chase and attack
		isAttacking = true;
		target = body;

func _on_detection_area_body_exited(body):
	if body.enemyType == self.enemyType: return;
	if body == target:
		target = null
		isAttacking = false
		#Look for somethign else
	
func _on_button_button_down():
	isHeld = true;
	collision_layer = 4;

func _on_button_button_up():
	isHeld = false;
	collision_layer = 1;
	
func _on_damage_taken(area: Area2D):
	if (area.damage != null):
		health -= area.damage * int(!isInvincible);
		$damage_cooldown.start(); 
		isInvincible = true;
		print("enemy health ", health)
		if health <= 0:
			self.queue_free()	

func _on_damage_cooldown_timeout():
	isInvincible = false
	
func _on_wander_timer_timeout():
	updateTargetPos()	