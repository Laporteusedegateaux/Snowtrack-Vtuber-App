extends Node

var save_data = {}

var FileHandler : Node

func _ready():
	FileHandler = $/root/PNGTuber/FileHandler
	#save_data["animation_speed"] = 1
	#save_data["image_scale"] = 1
	#save_data["blink_length"] = 3
	#save_data["time_to_blink"] = 0.5
	#save_data["selected_animation"] = 0

func load_settings_from_save():
	if save_data == null or save_data.is_empty() :
		return
	
	$/root/PNGTuber/UI.load_save_data(save_data)


func save_expressions_to_file(expressions):
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("user://%s/" % expressions["Name"]) :
		dir.make_dir("user://%s/" % expressions["Name"])
	
	var data = {}
	data["BlinkEnabled"] = expressions["BlinkEnabled"]
	data["MouthOpenEnabled"] = expressions["MouthOpenEnabled"]
	data["BlinkMouthOpenEnabled"] = expressions["BlinkMouthOpenEnabled"]
	FileHandler.save_data(data, "user://%s/Default.png" % expressions["Name"])
	
	if expressions.has("Default") and expressions["Default"] :
		FileHandler.save_image_to_folder(expressions["Default"], "user://%s/Default.png" % expressions["Name"])
	if expressions.has("Blink") and expressions["Blink"] :
		FileHandler.save_image_to_folder(expressions["Blink"], "user://%s/Blink.png" % expressions["Name"])
	if expressions.has("MouthOpen") and expressions["MouthOpen"] :
		FileHandler.save_image_to_folder(expressions["MouthOpen"], "user://%s/MouthOpen.png" % expressions["Name"])
	if expressions.has("BlinkMouthOpen") and expressions["BlinkMouthOpen"] :
		FileHandler.save_image_to_folder(expressions["BlinkMouthOpen"], "user://%s/BlinkMouthOpen.png" % expressions["Name"])
	
	FileHandler.save_data(save_data, "user://saved_settings.json")

func save_data_to_file():
	save_data[""]
