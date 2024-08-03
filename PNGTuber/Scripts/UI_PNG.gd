extends Control

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

#region - show/hide stuff
func _on_menu_button_pressed():
	$SettingsWindow.show()

func _on_button_images_pressed():
	hide_all()
	$SettingsWindow/Menus/Images.show()

func _on_button_PNGtuber_pressed():
	hide_all()
	$SettingsWindow/Menus/PNGtuber.show()

func _on_button_twitch_pressed():
	hide_all()
	$SettingsWindow/Menus/Twitch.show()

func _on_button_generic_pressed():
	hide_all()
	$SettingsWindow/Menus/Generic.show()
	

func hide_all():
	$SettingsWindow/Menus/Images.hide()
	$SettingsWindow/Menus/PNGtuber.hide()
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
	$MenuButton.button_pressed = false


func _on_button_save_pressed():
	var expression_containers = $SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageContainers.get_children()
	var expression_data = {}
	
	for container in expression_containers :
		var data = container.get_data()
		if data == null :
			return
		expression_data[data["Name"]] = data
	
	$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/OptionButton.clear()
	for i in expression_data :
		$SettingsWindow/Menus/Images/VBoxContainer/ScrollContainer/ImageFullContainer/ImageOptions/OptionButton.add_item(expression_data[i]["Name"])
	
	print(expression_data)
	$"..".update_expression(expression_data)
	$"../FileHandler".save_imagelist(expression_data)
