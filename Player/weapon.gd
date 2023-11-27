extends Node2D

var weapon: Area2D
#@onready var sword: Area2D = $sword

func _ready():
	if get_children().is_empty(): 
		return
	weapon = get_children()[0]
	
func enable():
	if !weapon: return
	visible = true
	weapon.enable()
	

func disable():
	if !weapon: return
	visible = false
	weapon.disable()
	
