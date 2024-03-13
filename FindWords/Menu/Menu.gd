extends Node2D

@onready var drop_down_menu = $CanvasLayer/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	add_items()


func add_items():
	drop_down_menu.add_item("5x5", 5)
	drop_down_menu.add_item("8X8", 8)
	drop_down_menu.add_item("10x10", 10)
	drop_down_menu.add_item("12x12", 12)
	drop_down_menu.add_item("15x15", 15)
	drop_down_menu.add_item("20x20", 20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	match index:
		0:
			Global.resGrid = 5
		1:
			Global.resGrid = 8
		2:
			Global.resGrid = 10
		3:
			Global.resGrid = 12
		4:
			Global.resGrid = 15
		5:
			Global.resGrid = 20
		_:
			push_error("ERROR")
			
	$Button.show()
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Grid/Grid.tscn")
