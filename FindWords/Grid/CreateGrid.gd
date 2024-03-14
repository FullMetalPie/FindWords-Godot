extends GridContainer

var rng = RandomNumberGenerator.new()
var grid_size = Global.resGrid
var grid = []
var style = StyleBoxFlat.new()
const LIMIT = 30

func _ready():
	style.bg_color = Color.WHITE
	style.border_color = Color.BLACK
	style.border_width_bottom = 1
	style.border_width_top = 1
	style.border_width_right = 1
	style.border_width_left = 1
	var cont = 0
	
	columns = grid_size
	for i in range(grid_size):
		var row = []
		for j in range(grid_size):
			var newCell = Label.new()
			newCell.custom_minimum_size = Vector2(50,50)
			newCell.add_theme_color_override("font_color", Color.BLACK)
			newCell.add_theme_stylebox_override("normal", style)
			newCell.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			newCell.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			newCell.text = " "
			add_child(newCell)
			row.append(newCell)
		grid.append(row)
		
	print(grid)
	generate_crossword()
		

func place_word(word, row, col, direction, reverse): #metodo utilizzato per inserire nelle celle le lettere delle parole una dopo l'altra
	if reverse:
		word = word.reverse()

	for i in range(word.length()):
		if direction == "horizontal":
			grid[row][col + i].text = str(word[i]).to_upper()
		elif direction == "vertical":
			grid[row + i][col].text = str(word[i]).to_upper()

func check_intersection(word, row, col, direction): #controlla se una parola entra nelle celle di una già posizionata
	print(word)
	for i in range(word.length()):
		print(i)
		if direction == "horizontal":
			if (grid[row][col + i]).text != " ":
				return true
		elif direction == "vertical":
			if (grid[row + i][col]).text != " ":
				return true
	return false

func generate_crossword(): #genera la tabella completa
	var cont = 0
	var direction
	var reverse

	for word in Global.words:
		cont = 0
		match rng.randi_range(0, 1):
			0:
				direction = "horizontal"
			1:
				direction = "vertical"

		match rng.randi_range(0, 1):
			0:
				reverse = true
			1:
				reverse = false

		var row = 0
		var col = 0
		var intersecting = true

		while intersecting:
			if cont > LIMIT: #se dopo LIMIT tentativi di posiziononamento di una parola viene mofificata la direzione di quest'ultima 
				if direction == "horizontal":
					direction = "vertical"
				else:
					direction = "horizontal"
			
			cont += 1
			
			if direction == "horizontal": #si vanno a definire le celle nelle quali dovrà essere inserita la parola
				row = rng.randi_range(0, grid_size - 1)
				col = rng.randi_range(0, grid_size - word.length())
			else:
				row = rng.randi_range(0, grid_size - word.length())
				col = rng.randi_range(0, grid_size - 1)
				
			intersecting = check_intersection(word, row, col, direction)
			
			

		place_word(word, row, col, direction, reverse)
	
	for i in range(grid_size): #andiamo a riempire le celle vuote con delle lettere generate casualmente
		for j in range(grid_size):
			if grid[i][j].text == " ":
				grid[i][j].text = str(char(rng.randi_range(65, 90)))
