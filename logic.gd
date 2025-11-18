extends Node
var can_ask = true
var file_path = "res://questions.tres"
# Function to open a text file and return its content as an array of lines
func open_text_file(file_path: String) -> Array:
	var file = File.new()
	var lines = []

	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		
		# Read the file line by line and add each line to the array
		while not file.eof_reached():
			lines.append(file.get_line())
		
		file.close()
	else:
		print("File does not exist!")
	
	return lines

# Function to print a random line from the file
func print_random_line(file_path: String):
	var lines = open_text_file(file_path)
	for line in lines: 
		if line == "": 
			lines.erase("")
	# Check if the file has lines
	if lines.size() > 0:
		var random_index = randi() % lines.size()  # Get a random index
		#print("Random line: ", lines[random_index])
		return lines[random_index]
	else:
		print("The file is empty or doesn't exist!")

func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	randomize()
	if Input.is_action_just_pressed("ask"):
		var respuesta = print_random_line(file_path)
		print(respuesta)	

func _on_ask_button_pressed():
	if can_ask:
		var respuesta = print_random_line(file_path)
		$respuesta.text = respuesta
		$peddler.frame = 1
		$ask_button.text = ""
		$peddler_animation_timer.start(3)
		can_ask = false
	else:
		pass


func _on_peddler_animation_timer_timeout():
	$peddler.frame = 0
	$ask_button.text = "PREGUNTA"
	$respuesta.text = "Pregúntale al Peddler"
	can_ask = true
