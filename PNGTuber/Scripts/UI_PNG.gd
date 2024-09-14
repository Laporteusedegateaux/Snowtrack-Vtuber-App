extends Node

@export var Expression_Container : PackedScene
@export var Expression_amount_limit : int

var Expression_Name
var Container_count : int

# press +
#window pops up asking for the expression's name
#if cancel, nothing happens
#if string is empty, button greys out
#if string is identical to existing one, button greys out
#if press ok, string is sent to the container to dispaly, and to the container list
#if the container is queue_freed, it notifies the list that it's not there anymore

func _ready():
	for i in range(0, Container_count):
		add_container("PHname%d" % i)
	
	var index = 0
	for i in $"../AnimationPlayer".get_animation_list() :
		#if i != "RESET" :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/AnimationChangeContainer/OptionButton.add_item(i, index)
		index += 1
	
	initialize_microphones()


func initialize_microphones():
	for device in AudioServer.get_input_device_list() :
		%MicrophoneSelect.add_item(device)

#region - show/hide stuff
func _on_menu_button_pressed():
	$SettingsWindow.show()

func _on_button_images_pressed():
	hide_all()
	$SettingsWindow/Menus/Images.show()

func _on_button_PNGtuber_pressed():
	hide_all()
	$SettingsWindow/Menus/Microphone.show()

func _on_button_twitch_pressed():
	hide_all()
	$SettingsWindow/Menus/Twitch.show()

func _on_button_generic_pressed():
	hide_all()
	$SettingsWindow/Menus/Generic.show()
	

func hide_all():
	$SettingsWindow/Menus/Images.hide()
	$SettingsWindow/Menus/Microphone.hide()
	$SettingsWindow/Menus/Generic.hide()
	$SettingsWindow/Menus/Twitch.hide()
#endregion

func _on_plus_button_pressed():
	add_container(null)

func add_container(expression_title):
	var instance = Expression_Container.instantiate()
	
	# check if tempname1 exists in list
	# if it does, check for tempname2
	# etc.
	# if it doesn't, add tempnameX to the list
	# then add tempnameX as metadata
	if expression_title != null :
		instance.set_meta("Expression Name", expression_title)
	else:
		# generate a name
		# for i in images
		#if $"../FileHandler".images["TempName{i}"].exists()
		#	i+1
		#else :
		#	$"../FileHandler".images["TempName{i}"] = Tempname{i}
		#	set_meta
		#	break loop
		pass
	$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers.add_child(instance)


func _on_settings_window_close_requested():
	$SettingsWindow.hide()
	$Canvas/MenuButton.button_pressed = false


func _on_button_save_pressed():
	var expression_containers = $SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers.get_children()
	var expression_data = {}
	
	for container in expression_containers :
		var data = container.get_data()
		if data == null :
			return
		expression_data[data["Name"]] = data
		
		SaveData.save_expressions_to_file(data)
	
	
	# TODO : implement manual expression change
	#$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/ExpressionChangeContainer/OptionButton.clear()
	#for i in expression_data :
		#$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/ExpressionChangeContainer/OptionButton.add_item(expression_data[i]["Name"])
	
	print(expression_data)
	$"..".update_expression(expression_data)
	

func load_save_data(data):
	if data.has("Default") and data["Default"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/DefaultContainer/Images/TextureRect.texture = data["Default"]
	if data.has("BlinkEnabled") and data["BlinkEnabled"] :
		#$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/BlinkContainer/Header/BlinkCheck.button_pressed = data["BlinkEnabled"]
		pass ## Not implemented
	if data.has("Blink") and data["Blink"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/BlinkContainer/Images/TextureRect.texture = data["Blink"]
	if data.has("MouthOpenEnabled") and data["MouthOpenEnabled"] :
		#$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/MouthOpenContainer/Header/MouthOpenCheck.button_pressed = data["MouthOpenEnabled"]
		pass ## Not implemented
	if data.has("MouthOpen") and data["MouthOpen"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/MouthOpenContainer/Images/TextureRect.texture = data["MouthOpen"]
	if data.has("BlinkMouthOpenEnabled") and data["BlinkMouthOpenEnabled"] :
		#$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/BlinkMouthOpenContainer/Header/BlinkMouthOpenCheck.button_pressed = data["BlinkMouthOpenEnabled"]
		pass ## Not implemented
	if data.has("BlinkMouthOpen") and data["BlinkMouthOpen"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers/ExpressionDefaultContainer/BlinkMouthOpenContainer/Images/TextureRect.texture = data["BlinkMouthOpen"]
	if data.has("BlinkDelay") and data["BlinkDelay"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/BlinkDelayContainer/BlinkDelay.value = data["BlinkDelay"]
	if data.has("BlinkRandom") and data["BlinkRandom"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/BlinkRandomContainer/BlinkRandom.value = data["BlinkRandom"]
	if data.has("BlinkLength") and data["BlinkLength"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/BlinkLengthContainer/BlinkLength.value = data["BlinkLength"]
	if data.has("ImageScale") and data["ImageScale"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/ImageScaleContainer/ImageScale.value = data["ImageScale"]
	if data.has("AnimationSpeed") and data["AnimationSpeed"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/AnimationSpeedContainer/AnimationSpeed.value = data["AnimationSpeed"]
	if data.has("SelectedAnimation") and data["SelectedAnimation"] :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/AnimationChangeContainer/OptionButton.select(int(data["SelectedAnimation"]))
	
	if data.has("MicThreshold") and data["MicThreshold"] :
		$SettingsWindow/Menus/Microphone/AudioSlider/GateSlider.value = data["MicThreshold"]
	if data.has("MicOffset") and data["MicOffset"] :
		$SettingsWindow/Menus/Microphone/AudioSlider/SoundOffset.value = data["MicOffset"]
	
	_on_button_save_pressed() # Reloads the data so the sprite is properly displayed and updated. Also saves the data again, which isn't ideal.


func _on_microphone_select_item_selected(index):
	var selected_microphone = %MicrophoneSelect.get_item_text(index)
	AudioServer.set_input_device(selected_microphone) 

