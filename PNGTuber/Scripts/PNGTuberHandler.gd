extends Node2D

var floor := 0
var offset := 0
var multiplier := 1

var time_to_blink : float
var time_between_blinks : int

var current_state : State

var blinkmouthopen_enabled : bool

enum State {DEFAULT, BLINK, MOUTHOPEN, BLINKMOUTHOPEN} 

signal state_changed 

var current_expression
var expressions_bank = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(randi_range(1,3))
	blinkmouthopen_enabled = false
	get_tree().root.set_flag(Window.FLAG_RESIZE_DISABLED, false)
	get_tree().root.set_flag(Window.FLAG_TRANSPARENT, true)
	get_tree().root.get_viewport().transparent_bg = true
	time_to_blink = 1
	
	$BlinkTimer.start(time_to_blink)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var vol = (get_microphone_volume() + offset)# * multiplier
	
	if $UI/SettingsWindow.visible == true :
		update_ui(vol)
	
	if vol > floor :
		state_changed.emit(State.MOUTHOPEN)
	else :
		state_changed.emit(State.DEFAULT)
	


func update_ui(vol):
	$UI/SettingsWindow/Menus/PNGtuber/AudioSlider/AudioVisualizer.value = vol
	
	if vol > 0:
		show_warning_high(true)
	elif vol < -100 :
		show_warning_low(true)
	else :
		show_warning_high(false)
		show_warning_low(false)

func update_expression(data):
	expressions_bank = data
	current_expression = "Default"
	
	#var frames = SpriteFrames.new()
	#
	#for i in data:
		#frames.add_animation(data[i]["Name"])
		#frames.add_frame(data[i]["Name"], data[i]["Default"], 1, 0)
		#if data[i]["BlinkEnabled"] == true :
			#frames.add_frame(data[i]["Name"], data[i]["Blink"], 1, 1)
		#if data[i]["MouthOpenEnabled"] == true :
			#frames.add_frame(data[i]["Name"], data[i]["MouthOpen"], 1, 2)
		#if data[i]["BlinkMouthOpenEnabled"] == true :
			#frames.add_frame(data[i]["Name"], data[i]["BlinkMouthOpen"], 1, 3)
		#
		##$AnimatedSprite2D.sprite_frames.clear(data[i]["Name"])
		#$AnimatedSprite2D.sprite_frames = frames

func _on_state_changed(state):
	#print("State has changed. New state : ", state)
	if expressions_bank.size() < 1 :
		return
	match state :
		State.DEFAULT:
			%PNGVtuber.texture = expressions_bank[current_expression]["Default"]
		State.BLINK:
			if current_state == State.MOUTHOPEN :
				_on_state_changed(State.BLINKMOUTHOPEN)
				return
			%PNGVtuber.texture = expressions_bank[current_expression]["Blink"]
		State.MOUTHOPEN:
			if current_state == State.BLINK :
				_on_state_changed(State.BLINKMOUTHOPEN)
				return
			%PNGVtuber.texture = expressions_bank[current_expression]["MouthOpen"]
		State.BLINKMOUTHOPEN:
			if expressions_bank[current_expression]["BlinkMouthOpenEnabled"] :
				%PNGVtuber.texture = expressions_bank[current_expression]["BlinkMouthOpen"]
	
	current_state = state

func get_microphone_volume():
	return AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Microphone"), 0)


func free_node(path):
	get_node(path).queue_free()


func show_warning_high(toggle):
	$UI/SettingsWindow/Menus/PNGtuber/AudioSlider/AudioVisualizer/WarningHigh.visible = toggle


func show_warning_low(toggle):
	$UI/SettingsWindow/Menus/PNGtuber/AudioSlider/AudioVisualizer/WarningLow.visible = toggle


func _on_gate_slider_value_changed(value):
	$UI/SettingsWindow/Menus/PNGtuber/AudioSlider/GateAmount.text = str(value, " dB")
	floor = value


func _on_sound_offset_value_changed(value):
	offset = value
	$UI/SettingsWindow/Menus/PNGtuber/AudioSlider/OffsetAmount.text = str(value, " dB")


func _on_sound_multiplier_value_changed(value):
	multiplier = value
	$UI/SettingsWindow/Menus/PNGtuber/AudioSlider/SoundMultiplierAmount.text = str(value)


func _on_blink_timer_timeout():
	state_changed.emit(State.BLINK)


func _on_blink_delay_value_changed(value):
	time_to_blink = value
	$BlinkTimer.start(time_to_blink)
