
extends CharacterBody3D

var speed = 2
var accel = 10

@onready var nav :NavigationAgent3D = $NavigationAgent3D

@export var new_velocity = Vector3(0,0,0)
@export var real_time_velocity = Vector3(0,0,0)
var old_velocty = Vector3(0,0,0)

@onready var target :Marker3D = get_node("../Marker3D")

func _physics_process(delta):
	var current_location = global_transform.origin
	nav.target_position = target.global_position
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity
	move_and_slide()
	
func update_target_location(target_location):
	nav.set_target_position(target_location)
	

	
	
	
func patrol(all_points :PackedVector3Array):
	pass
	
func idle():
	pass
func attack():
	pass
	
func conversation():
	pass
