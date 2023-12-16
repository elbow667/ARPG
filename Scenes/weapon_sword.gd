extends Area2D

@onready var shape: CollisionShape2D = $CollisionShape2D

func enable():
	#print_debug("sword enabled")
	shape.disabled = false
	
func disable():
	#print_debug("sword disabled")
	shape.disabled = true




