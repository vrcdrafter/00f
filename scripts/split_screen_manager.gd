
extends Node3D
var evaluate_controllers :bool = true


func _ready() -> void:
	pass
func _process(delta: float) -> void:

	var controllers_connected :int = check_controller()-1
	print(controllers_connected)
	if evaluate_controllers:
		match controllers_connected:
			0:
				# No controllers connected, handle accordingly (e.g., show a message)
				print("No controllers connected.")

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
	print(all_controllers)
	return all_controllers.size()


func duplicate_player_node(pos:Vector3):
	# Logic to duplicate player node goes here
	# For example:
	var new_player_node = preload("res://scenes/player_unit.tscn").instantiate()
	var player_handle :CharacterBody3D = new_player_node.get_node("SubViewport/Player")
	player_handle.position = pos
	$GridContainer.add_child(new_player_node)
