extends SpringArm

var _panSpeed : float = 1

func _ready():
	set_as_toplevel(true)

func _process(delta):
	CameraControls()



func CameraControls():
	var panDirection : Vector3 = Vector3.ZERO
	panDirection.y = Input.get_action_strength("panning_right") - Input.get_action_strength("panning_left")
	panDirection.x = Input.get_action_strength("panning_up") - Input.get_action_strength("panning_down")
	
	rotation_degrees.y -= panDirection.y * _panSpeed
	rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
	
	rotation_degrees.x -= panDirection.x * _panSpeed
	rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
