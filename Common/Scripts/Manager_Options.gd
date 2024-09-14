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
	SaveData.settings_data["resolution"] = previous_resolution
	SaveData.settings_data["window_mode"] = previous_windowmode

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


func _on_option_max_fps_selected(index):
	var fps = int($OptionMaxFPS.get_item_text(index))
	Engine.max_fps = fps
	SaveData.settings_data["frame_rate"] = fps


func _on_option_max_physics_selected(index):
	var rate = int($OptionMaxPhysics.get_item_text(index))
	Engine.max_physics_steps_per_frame = rate
	SaveData.settings_data["physics_rate"] = rate

func _on_check_box_vsync_toggled(toggled_on):
	if toggled_on :
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		SaveData.settings_data["vsync"] = true
	else :
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		SaveData.settings_data["vsync"] = false


#func _on_save_settings_pressed():
	#SaveData.save_settings_to_file()


func _on_check_box_lock_size_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, toggled_on)
	SaveData.settings_data["lock_window_size"] = toggled_on


func _on_option_anti_aliasing_item_selected(index):
	var main_window = get_tree().root
	match index :
		0 : # None
			main_window.set_screen_space_aa(0)
			main_window.set_msaa_2d(0)
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d", 0)
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 0)
		1 : # FXAA
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d", 0)
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 1)
		2 : # MSAA x2
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d", 1)
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 0)
		3 : # MSAA x4
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d", 2)
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 0)
		4 : # MSAA x8
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_2d", 3)
			ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 0)
