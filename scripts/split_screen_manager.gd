
extends Node3D


func _ready() -> void:

	var controllers_connected :int = check_controller()-1
	print(controllers_connected)
	
	match controllers_connected:
		0:
			# No controllers connected, handle accordingly (e.g., show a message)
			print("No controllers connected.")
		1:
			 # One controller connected, duplicate player node once
			duplicate_player_node(Vector3(0,0,0))
		2:
			 # One controller connected, duplicate player node once
			duplicate_player_node(Vector3(0,0,0))
			duplicate_player_node(Vector3(1,0,0))
		3:
			 # One controller connected, duplicate player node once
			duplicate_player_node(Vector3(0,0,0))
			duplicate_player_node(Vector3(1,0,0))
			duplicate_player_node(Vector3(2,0,0))
		4:
			 # One controller connected, duplicate player node once
			duplicate_player_node(Vector3(0,0,0))
			duplicate_player_node(Vector3(1,0,0))
			duplicate_player_node(Vector3(2,0,0))
			duplicate_player_node(Vector3(3,0,0))



	

func check_controller() -> int:
	var all_controllers :Array = Input.get_connected_joypads()
	print(all_controllers)
	return all_controllers.size()


func duplicate_player_node(pos:Vector3):
	# Logic to duplicate player node goes here
	# For example:
	var new_player_node = preload("res://scenes/player.tscn").instantiate()
	var player_handle :CharacterBody3D = new_player_node.get_node("SubViewportContainer/SubViewport/Player")
	player_handle.position = pos
	get_tree().get_root().add_child(new_player_node)
