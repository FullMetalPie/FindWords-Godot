extends GridContainer

var rng = RandomNumberGenerator.new()
var grid_size = Global.resGrid
var grid = []
var style = StyleBoxFlat.new()
const LIMIT = 30
var cont = 0
var flag_assolutism = false
var cont_parall = 0
var LIMIT_ERROR = 1000

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
		
	generate_crossword()
		

func place_word(word, row, col, direction, reverse): #metodo utilizzato per inserire nelle celle le lettere delle parole una dopo l'altra
	if reverse:
		word = word.reverse()

	for i in range(word.length()):
		if direction == "horizontal":
			grid[row][col + i].text = str(word[i]).to_upper()
		elif direction == "vertical":
			grid[row + i][col].text = str(word[i]).to_upper()
		elif direction == "oblique1":
			grid[row + i][col + i].text = str(word[i]).to_upper()
		else:
			grid[row + i][col - i].text = str(word[i]).to_upper()

func check_intersection(word, row, col, direction): #controlla se una parola entra nelle celle di una già posizionata
	print(word) #guardare per il controllo sull'intersecazione
	for i in range(word.length()):
		if direction == "horizontal":
			if (grid[row][col + i]).text != word[i] and (grid[row][col + i]).text != " ":
				return true
		elif direction == "vertical":
			if (grid[row + i][col]).text != word[i] and (grid[row + i][col]).text != " ":
				return true
		elif direction == "oblique1":
			if (grid[row + i][col + i]).text != word[i] and (grid[row + i][col + i]).text != " ":
				return true
		else:
			if (grid[row + i][col - i]).text != word[i] and (grid[row + i][col - i]).text != " ":
				return true
	return false

func generate_crossword(): #genera la tabella completa
	cont = 0
	var direction
	var reverse

	for word in Global.words:
		cont_parall = 0
		direction = generate_dir(word)
		if len(word) == Global.resGrid and (direction == "oblique1" or direction == "oblique2"):
			flag_assolutism = true
		
				
		match rng.randi_range(0, 1):
			0:
				reverse = true
			1:
				reverse = false

		var row = 0
		var col = 0
		var intersecting = true

		while intersecting and cont_parall <= LIMIT_ERROR:
			print(cont_parall)
			cont_parall += 1
			if cont <= LIMIT_ERROR:
				if cont > LIMIT: #se dopo LIMIT tentativi di posiziononamento di una parola viene mofificata la direzione di quest'ultima 
					direction = generate_dir(word)
					print("cambiato con nuova direzione: " + direction)
					
				
				cont += 1
				
				if direction == "horizontal": #si vanno a definire le celle nelle quali dovrà essere inserita la parola
					row = rng.randi_range(0, grid_size - 1)
					col = rng.randi_range(0, grid_size - word.length())
				elif direction == "vertical":
					row = rng.randi_range(0, grid_size - word.length())
					col = rng.randi_range(0, grid_size - 1)
				elif direction == "oblique1":
					row = rng.randi_range(0, grid_size - word.length())
					col = rng.randi_range(0, grid_size - word.length())
				else:
					row = rng.randi_range(0, grid_size - word.length())
					col = rng.randi_range(word.length() - 1, grid_size - 1)
					
				intersecting = check_intersection(word, row, col, direction)
				
				
				
		if cont_parall > LIMIT_ERROR:
			get_tree().change_scene_to_file.bind("res://error.tscn").call_deferred()
			
		place_word(word, row, col, direction, reverse)
	
	for i in range(grid_size): #andiamo a riempire le celle vuote con delle lettere generate casualmente
		for j in range(grid_size):
			if grid[i][j].text == " ":
				grid[i][j].text = str(char(rng.randi_range(65, 90)))


func generate_dir(word):
	cont = 0
	var dir
	if flag_assolutism:
		print("entrati nel flag")
		match rng.randi_range(0, 1):
			0:
				dir = "horizontal"
			1:
				dir = "vertical"
	else:
		match rng.randi_range(0, 3):
				0:
					dir = "horizontal"	
				1:
					dir = "vertical"
				2:
					dir = "oblique1"
				3:
					dir = "oblique2"
				
	return dir

