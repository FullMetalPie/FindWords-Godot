extends GridContainer

var col = 8
var style = StyleBoxFlat.new()


func _ready():
	style.bg_color = Color.WHITE
	style.border_color = Color.BLACK
	style.border_width_bottom = 2
	style.border_width_right = 2
	style.border_width_left = 2
	style.border_width_top = 2
	
	columns = col
	for i in (col*col):
		var newCell = Label.new()
		add_child(newCell)
		newCell.text = "casella"
		newCell.custom_minimum_size = Vector2(50, 50)
		newCell.add_theme_stylebox_override("normal", style)
		print("creato")
