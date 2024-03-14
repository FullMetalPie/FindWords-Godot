extends GridContainer

var rng = RandomNumberGenerator.new()
var grid_size = 12
var grid = []
var words = ["hello", "world", "python", "crossword", "generator", "piscitello", "abboffata"]

func _ready():
	for i in range(grid_size):
		var row = []
		for j in range(grid_size):
			row.append(" ")
		grid.append(row)

	generate_crossword()

func place_word(word, row, col, direction, reverse):
	if reverse:
		word = word.reverse()

	for i in range(word.length()):
		if direction == "horizontal":
			grid[row][col + i] = word[i]
		elif direction == "vertical":
			grid[row + i][col] = word[i]

func check_intersection(word, row, col, direction):
	for i in range(word.length()):
		if direction == "horizontal":
			if grid[row][col + i] != " ":# and grid[row][col + i] != word[i]:
				return true
		elif direction == "vertical":
			if grid[row + i][col] != " ":# and grid[row + i][col] != word[i]:
				return true
	return false

func generate_crossword():
	var direction
	var reverse
	var correct_words = []

	for word in words:
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
			if direction == "horizontal":
				row = rng.randi_range(0, grid_size - 1)
				col = rng.randi_range(0, grid_size - word.length())
			else:
				row = rng.randi_range(0, grid_size - word.length())
				col = rng.randi_range(0, grid_size - 1)

			intersecting = check_intersection(word, row, col, direction)

		place_word(word, row, col, direction, reverse)
		correct_words.append(word)
	
	for row in grid:
		print(row)
	
	for i in range(grid_size):
		for j in range(grid_size):
			if grid[i][j] == " ":
				grid[i][j] = str(char(rng.randi_range(65, 90)))

	for row in grid:
		print(row)
