extends CharacterBody2D
class_name Player

signal healthChanged

@export var speed: int = 35
@onready var animations: = $AnimationPlayer
@onready var effects: = $Effects
@onready var hurtBox: = $Hurtbox
@onready var hurtTimer: = $hurtTimer

@export var maxHealth: int = 3
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

@export var inventory: Inventory

var ishurt : bool = false



func _ready():
	effects.play("RESET")

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * speed

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animations.play("walk" + direction)
		
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)
		
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if !ishurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "HitBox":
				hurtByEnemy(area)
			
func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
			
	healthChanged.emit(currentHealth)
	ishurt = true
	
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	ishurt = false
	
func _on_hurtbox_area_entered(area):
	if area.has_method("collect"):
		area.collect()

		

func knockback(enemyVelocity):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()
	
	


func _on_hurtbox_area_exited(area):
	pass

