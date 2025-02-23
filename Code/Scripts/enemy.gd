extends CharacterBody2D
class_name enemy

#Sync
var rng = RandomNumberGenerator.new()
var player_chase = false
var player = null
var enemy_in_attack_zone = false
var can_take_damage = true
var damage_taken = 0
var is_being_held = false
var start_position = global_position
var target_position = global_position
var walk = false;
@onready var interaction_area: InteractionArea = $InteractionArea
@export var startX: int = 0
@export var startY: int = 0

#Individual values
var health = 50
var atk = 5
var speed = 20
var stage = 0

func _ready():
	position = Vector2(startX, startY)
	updateTargetPos()
	interaction_area.interact = Callable(self, "_on_interact")

func _physics_process(delta):
	updateForm()
	
	if(!is_being_held):
		animate()
		if(stage == 2):
			#damage()
			if player_chase:
				position += (player.position - position)/speed
				
				$AnimatedSprite2D.play("2_walk")
				if(player.position.x - position.x) < 0:
					$AnimatedSprite2D.flip_h = true
				else:
					$AnimatedSprite2D.flip_h = false
			else:
				wander()
		else:
			wander()
	else:
		position = get_global_mouse_position()
		startX = get_global_mouse_position().x
		startY = get_global_mouse_position().y
		target_position = Vector2(startX, startY)
		walk = false
		animate()

func updateForm():
	if(stage != global.stage):
		stage = global.stage

func enemy():
	pass

func damage():
	if enemy_in_attack_zone:
		if can_take_damage:
			health = health - damage_taken
			$damage_cooldown.start()
			can_take_damage = false
			print("enemy health ", health)
			if health <= 0:
				self.queue_free()

func updateTargetPos():
	rng.randomize()
	var targetVec = Vector2(rng.randf_range(-32,32), rng.randf_range(-32,32))
	target_position = Vector2(startX, startY) + targetVec

func animate():
	if(walk):
		if(stage == 0):
			$AnimatedSprite2D.play("0_walk")
		if(stage == 1):
			$AnimatedSprite2D.play("1_walk")
		if(stage == 2):
			$AnimatedSprite2D.play("2_walk")
	if(!walk):
		if(stage == 0):
			$AnimatedSprite2D.play("0_idle")
		if(stage == 1):
			$AnimatedSprite2D.play("1_idle")
		if(stage == 2):
			$AnimatedSprite2D.play("2_idle")

func wander():
	if(int(position.x) == int(target_position.x) && int(position.y) == int(target_position.y)):
		walk = false;
	else:
		position += (target_position - position)/speed
		walk = true;
		if(target_position - position) < Vector2(0,0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

func _on_interact():
	print("Interacted With")

func _on_wander_timer_timeout():
	updateTargetPos()

func _on_damage_cooldown_timeout():
	can_take_damage = true

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("cow"):
		enemy_in_attack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("cow"):
		enemy_in_attack_zone = false

func _on_button_button_down():
	is_being_held = true;
	collision_layer = 4;

func _on_button_button_up():
	is_being_held = false;
	collision_layer = 1;
