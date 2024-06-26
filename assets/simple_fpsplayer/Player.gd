
extends CharacterBody3D

const ACCEL = 10
const DEACCEL = 30

const SPEED = 5.0
const SPRINT_MULT = 2
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.06
@export var player_id :String = "0"

var joy_y_accum:float = 0
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var camera
var rotation_helper :Node3D
var dir = Vector3.ZERO
var flashlight
var Joy_sensativity :float = 0.05
var shift_numbers :bool = false
@onready var top_node_master :Node3D = get_node("/root/Node3D")

func _ready():
	camera = $rotation_helper/Camera3D
	rotation_helper = $rotation_helper
	flashlight = $rotation_helper/Camera3D/flashlight_player
	player_id = find_id()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var shifter = Callable(self,"shift_the_numbers")
	top_node_master.connect("Shift_the_numbers",shifter)
	

func _input(event):
	# This section controls your player camera. Sensitivity can be changed.
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation
		camera_rot.x = clampf(camera_rot.x, -1.4, 1.4)
		print(camera_rot)
		rotation_helper.rotation = camera_rot


	# Release/Grab Mouse for debugging. You can change or replace this.
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Flashlight toggle. Defaults to F on Keyboard.
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			if flashlight.is_visible_in_tree() and not event.echo:
				flashlight.hide()
			elif not event.echo:
				flashlight.show()

func _physics_process(delta):
	
	# re assign numbers if this goes true number
	if shift_numbers:
		print("pleas go into here to re-ases")
		player_id = find_id()
		shift_numbers = false

	#joystick up down 
		
	var look_stick_angle :Vector2 = Input.get_vector("look_left_p"+player_id,"look_right_p"+player_id,"look_up_p"+player_id,"look_down_p"+player_id)
	print("look stick angle", look_stick_angle, player_id)
	joy_y_accum = look_stick_angle.y * Joy_sensativity
	rotation_helper.rotate_x(joy_y_accum * -1)
	#joystick left right
	self.rotate_y(look_stick_angle.x * Joy_sensativity * -1)
	
	var moving = false
	# Add the gravity. Pulls value from project settings.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump_p"+player_id) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# This just controls acceleration. Don't touch it.
	var accel
	if dir.dot(velocity) > 0:
		accel = ACCEL
		moving = true
	else:
		accel = DEACCEL
		moving = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with a custom keymap depending on your control scheme. These strings default to the arrow keys layout.
	var input_dir = Input.get_vector("pan_left_p"+player_id, "pan_right_p"+player_id, "move_forward_p"+player_id, "move_backward_p"+player_id)
	$AnimationTree.set("parameters/BlendSpace2D/blend_position",input_dir)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * accel * delta
	if Input.is_key_pressed(KEY_SHIFT) or Input.is_action_pressed("sprint_p"+player_id):
		direction = direction * SPRINT_MULT
	else:
		pass

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
func find_id() -> String:
	var host_node_name = get_node("../..")
	# check the size of controolers 
	var num_of_controlers :int = Input.get_connected_joypads().size()
	print("we got this many devices ", num_of_controlers)
	var name_string :String = host_node_name.name as String
	var contoller_id = "0"
	if name_string.contains("0"):
		
		if shift_numbers:
			contoller_id = "1"
			print("shifted", shift_numbers)
		else:
			print("ent here ", shift_numbers)
			contoller_id = "0"
	if name_string.contains("1"):
		if shift_numbers:
			contoller_id = "2"
		else:
			contoller_id = "1"
	if name_string.contains("3"):
		if shift_numbers: 
			contoller_id = "3"
		else:
			contoller_id = "2"
	return contoller_id

func shift_the_numbers():
	print("please shift numbers")
	shift_numbers = true
