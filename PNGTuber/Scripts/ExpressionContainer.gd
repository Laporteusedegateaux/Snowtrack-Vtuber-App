extends Node

var current_selection

var expressions := {}
# Name - string
# Default - Texture
# DefaultEnabled - bool
# Blink - Texture
# BlinkEnabled - bool
# MouthOpen - Texture
# MouthOpenEnabled - bool
# BlinkMouthOpen - Texture
# BlinkMoutOpenEnabled - bool

func _ready():						
	if $DefaultContainer/Images/TextureRect.texture :
		expressions["Default"] = $DefaultContainer/Images/TextureRect.texture
		print("Set texture at ready")
	if $BlinkContainer/Images/TextureRect.texture :
		expressions["Blink"] = $BlinkContainer/Images/TextureRect.texture
		print("Set texture at ready")
	if $MouthOpenContainer/Images/TextureRect.texture :
		expressions["MouthOpen"] = $MouthOpenContainer/Images/TextureRect.texture
		print("Set texture at ready")
	if $BlinkMouthOpenContainer/Images/TextureRect.texture :
		expressions["BlinkMouthOpen"] = $BlinkMouthOpenContainer/Images/TextureRect.texture


func _on_signal():
	queue_free()

func create_texture(load_path) -> Texture:
	var image = Image.new()
	var err = image.load(load_path)
	if err != OK:
		printerr("Load image failed: ", err)
	var texture = ImageTexture.new()
	return texture.create_from_image(image)


func get_data():
	expressions["BlinkEnabled"] = $BlinkContainer/Header/BlinkCheck.button_pressed
	expressions["MouthOpenEnabled"] = $MouthOpenContainer/Header/MouthOpenCheck.button_pressed
	expressions["BlinkMouthOpenEnabled"] = $BlinkMouthOpenContainer/Header/BlinkMouthOpenCheck.button_pressed
	
	if self.name == "ExpressionDefaultContainer" :
		expressions["Name"] = "Default"
	if expressions.has("Name") and expressions["Name"] :
		return expressions
	else :
		var error = AcceptDialog.new()
		#error.set_exclusive(true)
		error.set_text("An expression has no name!")
		error.dialog_close_on_escape = true
		error.set_initial_position(Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN)
		error.set_flag(Window.FLAG_ALWAYS_ON_TOP, true)
		get_tree().root.add_child(error)
		error.confirmed.connect($"../../../../../../../../..".free_node.bind(error.get_path()))
		error.canceled.connect($"../../../../../../../../..".free_node.bind(error.get_path()))
		error.show()
		return null


func _on_file_get_dialog_file_selected(path):
	print(path, " | ", current_selection)
	var new_texture = create_texture(path)
	
	#$"../../../../../../../../FileHandler".images[current_selection] = new_texture
	#print($"../../../../../../../../FileHandler".images[current_selection])
	match current_selection :
		"Default":
			$DefaultContainer/Images/TextureRect.texture = new_texture
			
		"Blink":
			$BlinkContainer/Images/TextureRect.texture = new_texture
		
		"MouthOpen":
			$MouthOpenContainer/Images/TextureRect.texture = new_texture
		
		"BlinkMouthOpen":
			$BlinkMouthOpenContainer/Images/TextureRect.texture = new_texture
	expressions[current_selection] = new_texture

func _on_button_pressed(expression):
	var file_picker = FileDialog.new()
	print(expression)
	file_picker.ACCESS_FILESYSTEM
	file_picker.add_filter("*.png")
	file_picker.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_picker.set_flag(Window.FLAG_ALWAYS_ON_TOP, true)
	file_picker.set_exclusive(true)
	file_picker.set_initial_position(Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN)
	file_picker.size = Vector2(500, 500)	
	file_picker.show()
	get_tree().root.add_child(file_picker)
	file_picker.file_selected.connect(_on_file_get_dialog_file_selected.bind())
	file_picker.canceled.connect($"../../../../../../../../..".free_node.bind(file_picker.get_path()))
	
	match expression :
		"Default": # Default
			current_selection = "Default"
		"Blink": #Blink
			current_selection = "Blink"
		"MouthOpen": # MouthOpen
			current_selection = "MouthOpen"
		"BlinkMouthOpen": #BlinkMouthOpen
			current_selection = "BlinkMouthOpen"
	
	file_picker.show()

func _on_expression_name_text_changed(new_text):
	expressions["Name"] = new_text


func _on_check_toggled(toggled_on, type_name:String):
	type_name += "Enabled"
	print("Changing value: ", type_name)
	expressions[type_name] = toggled_on
