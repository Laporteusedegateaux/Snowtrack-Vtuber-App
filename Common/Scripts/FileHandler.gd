extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var error = read_data()
	if error == null :
		SaveData.save_data = {}
	else :
		SaveData.save_data = error
	
	SaveData.load_settings_from_save()


func save_image_to_folder(buffer, filepath: String):
	var image = Image.new()
	print(buffer.get_class())
	if buffer.get_class() == "CompressedTexture2D" :
		image = buffer.get_image()
	elif buffer.get_class() == "ImageTexture" :
		image = buffer.get_image()
	
	if filepath.ends_with("png"):
		#var error = image.load_png_from_buffer(buffer)
		#if error != OK:
			#push_error("Couldn't load the image.")
			#return null
		image.save_png(filepath)
	elif filepath.ends_with("webp"):
		#var error = image.load_webp_from_buffer(buffer)
		#if error != OK:
			#push_error("Couldn't load the image.")
			#return null
		image.save_webp(filepath)
	elif filepath.ends_with("jpg"):
		#var error = image.load_jpg_from_buffer(buffer)
		#if error != OK:
			#push_error("Couldn't load the image.")
			#return null
		image.save_jpg(filepath)
	else:
		push_error("unsupported format")
		return
		
	print("static image saved: %s" % filepath)

func save_data(data, path):
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json_string)


func read_data():
	var json = JSON.new()
	var data
	if FileAccess.file_exists("user://saved_settings.json"):
		var file_string = FileAccess.get_file_as_string("user://saved_settings.json")
		data = json.parse_string(file_string)
	
	var dir = DirAccess.open("user://")
	if dir.dir_exists("user://Default"):
		for file in dir.get_files_at("user://Default") :
			var image = Image.new()
			var error = image.load("user://Default/%s" % file)
			if error != OK:
				return null
			data[str(file).left(str(file).rfind("."))] = ImageTexture.create_from_image(image)
			print(file)
			print(str(file).left(str(file).rfind(".")))
			
	
	return data

#func _on_save_timer_timeout():
	#save_imagelist()
