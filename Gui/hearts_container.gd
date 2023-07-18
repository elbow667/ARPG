extends HBoxContainer

@onready var HeartGuiClass = preload("res://Gui/heart_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setMaxHearts(maxHearts: int):
	for i in range(maxHearts):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
	
func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	for i in range(currentHealth):
		hearts[i].update(true)
	
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
