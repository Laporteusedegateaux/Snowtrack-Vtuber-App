extends GridContainer

var previous_resolution
var previous_windowmode

var TargetWindow : Window

# Called when the node enters the scene tree for the first time.
func _ready():
	TargetWindow = get_tree().root
	previous_resolution = TargetWindow.get_size()
	previous_windowmode = TargetWindow.get_mode()


func rollback_settings():
	TargetWindow.set_size(previous_resolution)
	TargetWindow.set_mode(previous_windowmode)
	#set_ui_size(previous_resolution)

func validate_settings():
	previous_resolution = TargetWindow.get_size()
	previous_windowmode = TargetWindow.get_mode()

#func set_ui_size(new_size : Vector2):
	#var ui_list = $FullMenu.get_children()
	#for i in ui_list:
		#i.custom_minimum_size = new_size

func _on_option_resolution_selected(index):
	previous_resolution = TargetWindow.get_size()
	var new_resolution : Vector2
	match index :
		0 :
			new_resolution = Vector2(3440.0, 1440.0)
		1 :
			new_resolution = Vector2(2160.0, 1080.0)
		2 :
			new_resolution = Vector2(2160.0, 1440.0)
		3 :
			new_resolution = Vector2(1920.0, 1080.0)
		4 :
			new_resolution = Vector2(1600.0, 900.0)
		5 :
			new_resolution = Vector2(1280.0, 720.0)
	TargetWindow.set_size(new_resolution)
	#set_ui_size(new_resolution)
	$ConfirmationDialog.show()
	$ConfirmationDialog/ConfirmationTimer.start(15)


func _on_confirmation_dialog_canceled():
	rollback_settings()
	


func _on_confirmation_dialog_confirmed():
	validate_settings()
	$ConfirmationDialog/ConfirmationTimer.stop()


func _on_confirmation_timer_timeout():
	rollback_settings()
	$ConfirmationDialog.hide()


func _on_option_windowed_selected(index):
	var new_windowmode
	match index :
		0 :
			new_windowmode = TargetWindow.WINDOW_MODE_WINDOWED
		1 :
			new_windowmode = TargetWindow.WINDOW_MODE_FULLSCREEN
		2 :
			new_windowmode = TargetWindow.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	TargetWindow.set_mode(new_windowmode)
	$ConfirmationDialog.show()
	$ConfirmationDialog/ConfirmationTimer.start(15)
