extends Node2D

@onready var drop_down_menu = $CanvasLayer/OptionButton
var cont = 0
var selected = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	add_items()


func add_items():
	drop_down_menu.add_item("-", 5)
	drop_down_menu.add_item("5x5", 5)
	drop_down_menu.add_item("8X8", 8)
	drop_down_menu.add_item("10x10", 10)
	drop_down_menu.add_item("12x12", 12)
	drop_down_menu.add_item("17x17", 17)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	match index:
		1:
			fill_Info(5, Global.MAX5)
		2:
			fill_Info(8, Global.MAX8)
		3:
			fill_Info(10, Global.MAX10)
		4:
			fill_Info(12, Global.MAX12)
		5:
			fill_Info(17, Global.MAX17)
		_:
			push_error("ERROR")
			
	$CanvasLayer/OptionButton.disabled = true
	$CanvasLayerParole.show()
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Grid/Grid.tscn")


func _on_button_submit_pressed():
	if cont != selected:
		var new_word = str($CanvasLayerParole/Label_PAROLE/TextEdit.text)
		if len(new_word) <= Global.resGrid and len(new_word) != 0:
			Global.words.append(new_word.strip_edges())
			$CanvasLayerParole/Label_PAROLE/TextEdit.text = ""
			$CanvasLayerParole/Label_PAROLE.text = "\n RIMANENTI: " + str((selected - 1 - cont)) + "\nLUNGHEZZA MAX PAROLA: " + str(Global.resGrid)
			print(Global.words)
			if selected - 1 == cont:
				$CanvasLayerParole.hide()
				$Button.show()
			cont += 1
			


func fill_Info(grid_dim, max_word):
	Global.resGrid = grid_dim
	$CanvasLayerParole/Label_PAROLE.text += "\n INSERIRE " + str(max_word) + " PAROLE\nLUNGHEZZA MAX PAROLA: " + str(Global.resGrid) 
	selected = max_word
	print(selected)
