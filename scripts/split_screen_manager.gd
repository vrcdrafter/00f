
extends Node3D
var evaluate_controllers :bool = true


func _ready() -> void:
	
	var callable = Callable(self, "act_on_connection")
	#start initial scene with one
	
	Input.joy_connection_changed.connect(callable)

	

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
	
	if _connected and _device != 1:
		# add another player
		duplicate_player_node(Vector3(_device,0,0))
	if _connected and _device == 1:
		get_node("GridContainer/SubViewportContainer_0").queue_free()
		
		duplicate_player_node(Vector3(_device,0,0))
