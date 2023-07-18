extends "res://Scenes/collectable.gd"

@onready var animations = $AnimationPlayer

func collect():
	animations.play("Spin")
	await animations.animation_finished
	super.collect()
	



