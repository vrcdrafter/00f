
extends PhysicalBoneSimulator3D

var array = ["Spine.001","Spine.002","Spine.003","Spine.004"]

@export var pause_simulation = false

# Called when the node enters the scene tree for the first time.
func _ready():
	physical_bones_start_simulation(array)
	
	if pause_simulation:
		print("went there")
		physical_bones_stop_simulation()
	#pass
