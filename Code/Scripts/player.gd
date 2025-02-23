extends CharacterBody2D

var enemyType = "None"
const speed = 200
var current_dir = "none"
var crop0 = preload("res://Level/Prefabs/crops/crop0.tscn")
var crop1 = preload("res://Level/Prefabs/crops/crop1.tscn")
var crop2 = preload("res://Level/Prefabs/crops/crop2.tscn")
var crop3 = preload("res://Level/Prefabs/crops/crop3.tscn")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var player_alive = true
var attack_ip = false

var health = 100
var atk = 10

var damage_taken = 0

func _ready():
	$AnimatedSprite2D.play("sideIdle")

func _physics_process(delta):
	if !global.diaActive:
		player_movement(delta)
		pausing()
		addCrop()
		
func pausing():
	if Input.is_action_just_pressed("Pause"):
		SceneManager.toggle_pause();
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("sideWalk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("sideIdle")
			
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("sideWalk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("sideIdle")
			
	elif dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("frontWalk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("frontIdle")
			
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("backWalk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("backIdle")

func addCrop():
	var instance = crop0.instantiate()
	if(global.has_crop):
		if(global.crop_type == 0):
			instance = crop0.instantiate()
			add_child(instance)
		if(global.crop_type == 1):
			instance = crop1.instantiate()
			add_child(instance)
		if(global.crop_type == 2):
			instance = crop2.instantiate()
			add_child(instance)
		if(global.crop_type == 3):
			instance = crop3.instantiate()
			add_child(instance)

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D):
	if body.has_method("enemy"):
		damage_taken = body.atk

func _on_player_hitbox_body_exited(body: Node2D):
	pass # Replace with function body.
