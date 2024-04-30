
extends Node3D
var evaluate_controllers :bool = true


func _ready() -> void:
	
	var callable = Callable(self, "act_on_connection")
	
	Input.joy_connection_changed.connect(callable)
func _process(delta: float) -> void:

	var controllers_connected :int = check_controller()-1
	
	
	if evaluate_controllers:
		match controllers_connected:
			0:
				# No controllers connected, handle accordingly (e.g., show a message)
				duplicate_player_node(Vector3(0,0,0))
				print("No controllers connected.")
				evaluate_controllers = false

			1:
				 # One controller connected, duplicate player node once
				duplicate_player_node(Vector3(0,0,0))
				print("I have one controller")
				evaluate_controllers = false
			2:
				 # One controller connected, duplicate player node once
				duplicate_player_node(Vector3(0,0,0))
				
				duplicate_player_node(Vector3(1,0,0))
				print("I have two controllers")
				evaluate_controllers = false
			3:
				 # One controller connected, duplicate player node once
				duplicate_player_node(Vector3(0,0,0))
				duplicate_player_node(Vector3(1,0,0))
				duplicate_player_node(Vector3(2,0,0))
				evaluate_controllers = false
			4:
				 # One controller connected, duplicate player node once
				duplicate_player_node(Vector3(0,0,0))
				duplicate_player_node(Vector3(1,0,0))
				duplicate_player_node(Vector3(2,0,0))
				duplicate_player_node(Vector3(3,0,0))
				evaluate_controllers = false



	

func check_controller() -> int:
	var all_controllers :Array = Input.get_connected_joypads()
	
	return all_controllers.size()


func duplicate_player_node(pos:Vector3):
	# Logic to duplicate player node goes here
	# For example:
	var new_player_node = preload("res://scenes/player_unit.tscn").instantiate()
	var player_handle :CharacterBody3D = new_player_node.get_node("SubViewport/Player")
	player_handle.position = pos
	$GridContainer.add_child(new_player_node)

func act_on_connection(_device, _connected):
	print("hey you connected something, it was ",_device, "its plugged in ",_connected)
