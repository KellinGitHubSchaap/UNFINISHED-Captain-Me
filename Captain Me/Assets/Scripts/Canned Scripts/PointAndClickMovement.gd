extends KinematicBody

var _walkSpeed : float = 10.0
var _currentSpeed : float = 0.0

var _accelaration : int = 200
var _isWalking : bool = false

var _newDestination : Vector3
var _movement : Vector3
var _moveDir

func _process(delta):
	if(!_isWalking):
		_currentSpeed = 0;
	else:
		_currentSpeed += _accelaration * delta
		if(_currentSpeed > _walkSpeed):
			_currentSpeed = _walkSpeed
	
	_movement = transform.origin.direction_to(_newDestination) * _currentSpeed
	_moveDir = rad2deg(_newDestination.angle_to(transform.origin))
	
	if(transform.origin.distance_to(_newDestination) > 1.7):
		_movement = move_and_slide(_movement)
	else:
		_isWalking = false
	

func _unhandled_input(event):
	if(event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		if(event.is_pressed()):
			var rayLength = 1000
			var camera = get_parent().get_node("Camera")
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * rayLength
			var spaceState = get_world().get_direct_space_state()
			var result = spaceState.intersect_ray(from, to)
			
			if(result):
				_newDestination = result.position
				_isWalking = true
				print(result.position)

func WalkToNewDestination(var newDestination : Vector3):
	pass

