extends GridContainer

var rng = RandomNumberGenerator.new()
# Define your grid size
var grid_size = 12

# Store the grid as an array
var grid = []

# Words array
var words = ["hello", "world", "python", "crossword", "generator"]

func _ready():
	# Initialize the grid with empty strings
	for i in range(grid_size):
		var row = []
		for j in range(grid_size):
			row.append(" ")
		grid.append(row)
	
	# Call the function to generate crossword
	generate_crossword()
	
func place_word(word, row, col, direction, reverse):
	if reverse:
		word = word.reverse()
	
	for i in range(word.length()):
		if direction == "horizontal":
			grid[row][col + i] = word[i]
		elif direction == "vertical":
			grid[row + i][col] = word[i]

func generate_crossword():
	var direction
	var reverse
	var correct_words = [] # List to store correct words

	for word in words:
		match rng.randi_range(0,1):
			0:
				direction = "horizontal"
			1:
				direction = "vertical"
				
		match rng.randi_range(0,1):
			0:
				reverse = true
			1:
				reverse = false
				
		var row = 0
		var col = 0

		if direction == "horizontal":
			row = rng.randi_range(0, grid_size - 1)
			col = rng.randi_range(0, grid_size - word.length())
		else:
			row = rng.randi_range(0, grid_size - word.length())
			col = rng.randi_range(0, grid_size - 1)

		place_word(word, row, col, direction, reverse)
		correct_words.append(word)

	# Fill unused grid cells with random letters
	for i in range(grid_size):
		for j in range(grid_size):
			if grid[i][j] == " ":
				grid[i][j] = str(char(rng.randi_range(65, 90)))

	# Print the grid (you might want to draw it differently in Godot)
	for row in grid:
		print(row)
