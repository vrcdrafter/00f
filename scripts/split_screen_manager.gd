
extends Node3D
var evaluate_controllers :bool = true
signal Shift_the_numbers
var shift_numbers :bool = false


func _ready() -> void:
	
	var callable = Callable(self, "act_on_connection")
	#start initial scene with one
	
	Input.joy_connection_changed.connect(callable)
	$Timer.start(1) # this timer determines if the controller device should be incremented , its 0 if the devices are plugged in , else it starts at 1
	

func check_controller() -> int:
	var all_controllers :Array = Input.get_connected_joypads()
	
	return all_controllers.size()


func duplicate_player_node(pos:Vector3): # need optional argument to force name 
	# Logic to duplicate player node goes here
	# For example:
	var new_player_node = preload("res://scenes/player_unit.tscn").instantiate()
	var player_handle :CharacterBody3D = new_player_node.get_node("SubViewport/Player")
	player_handle.position = pos
	
	# poll node to reload
	var count = 0 
	print(get_children())
	for child in get_node("GridContainer").get_children():
		if child is SubViewportContainer:
			count += 1
	print(count)
	new_player_node.name = "SubViewportContainer_" + str(count)
	$GridContainer.add_child(new_player_node)


func act_on_connection(_device, _connected):
	print("hey you connected something, it was ",_device, " its plugged in ",_connected)
	# if more controllerd added after scene started shift number +1 

	if _connected and _device != 1:
		# add another player
		duplicate_player_node(Vector3(_device,0,0))
	if shift_numbers:
		print("emitted shift signal ")
		Shift_the_numbers.emit()

func _on_timer_timeout() -> void:
	print("out of time increment controller sequence ")
	shift_numbers = true
	
