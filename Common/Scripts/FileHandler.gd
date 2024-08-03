extends Node

var images = {} # {String path, ImageTexture image}
# Looking at this ^ a LOT later... Why? I don't get it.

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists("user://PNGTuberImageList.save"):
		print("Loading PNGTuber images.")
		var file = FileAccess.open("user://PNGTuberImageList.save", FileAccess.READ)
		var content = file.get_as_text().rstrip(",")
		images = content.split(",") 
		print(images)
	else:
		print("No file found for PNGTuber.")


func save_imagelist(given_data):
	var data : String = ""
	#var path_string = "res://PNGTuber/SavedImages/"
	for i in images:
		data += i
		data += ","
		#save_image_to_folder(i, str(path_string + image name)
	# Remove the last ","
	data.rstrip(",")
	var file = FileAccess.open("res://PNGTuberImageList.save", FileAccess.WRITE)
	
	
	
	
	print("saved data: ", data)
	#file.store_string(data)

func save_image_to_folder(buffer: PackedByteArray, filepath: String):
	var image = Image.new()
	
	if filepath.ends_with("png"):
		var error = image.load_png_from_buffer(buffer)
		if error != OK:
			push_error("Couldn't load the image.")
			return null
		image.save_png(filepath)
	elif filepath.ends_with("webp"):
		var error = image.load_webp_from_buffer(buffer)
		if error != OK:
			push_error("Couldn't load the image.")
			return null
		image.save_webp(filepath)
	elif filepath.ends_with("jpg"):
		var error = image.load_jpg_from_buffer(buffer)
		if error != OK:
			push_error("Couldn't load the image.")
			return null
		image.save_jpg(filepath)
	else:
		push_error("unsupported format")
		return
		
	print("[tmi/img]: static image saved: %s" % filepath)


#func _on_save_timer_timeout():
	#save_imagelist()
