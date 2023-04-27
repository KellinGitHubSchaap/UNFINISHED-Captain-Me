extends KinematicBody

var _movementSpeed : float = 7.0
var _carrySpeed : float = _movementSpeed / 1.5
var _currentSpeed : float = _movementSpeed

var _gravity : float = 125.0
var _rotationSpeed : float = 25.0

var _velocity : Vector3 = Vector3.ZERO
var _snapVector : Vector3 = Vector3.DOWN

onready var _springArm : SpringArm = $SpringArm
onready var _model : Spatial = $Owl

var _isClimbing : bool = false
var _climbSpeed : float = 5.0

func _physics_process(delta):
	var moveDirection : Vector3 = Vector3.ZERO
	moveDirection.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	moveDirection.z = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	
	if(!_isClimbing):
		NormalMovement(delta, moveDirection)
		_velocity = move_and_slide_with_snap(_velocity, _snapVector, Vector3.UP, true)
	else:
		ClimbMovement(delta, moveDirection)
		_velocity = move_and_slide_with_snap(_velocity, Vector3.ZERO, Vector3.UP)



func NormalMovement(var delta, var moveDirection : Vector3):
	moveDirection = moveDirection.rotated(Vector3.UP, _springArm.rotation.y).normalized()
	
	_velocity.x = moveDirection.x * _currentSpeed
	_velocity.z = moveDirection.z * _currentSpeed
#	_particleTrail.direction = Vector3(-_velocity.x, _particleTrail.direction.y, -_velocity.z)
	_velocity.y -= _gravity * delta
	
	var isGrounded : bool = is_on_floor() and _snapVector == Vector3.ZERO
	
	if(isGrounded):
		_snapVector = Vector3.DOWN
#		if(moveDirection != Vector3.ZERO):
#			_particleTrail.emitting = true
#		else:
#			_particleTrail.emitting = false
	else:
		_snapVector = Vector3.ZERO
#		_particleTrail.emitting = false
	
	if(Vector2(_velocity.z, _velocity.x).length() > 0.2):
		var lookDir = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = lerp_angle(_model.rotation.y,lookDir.angle(), delta * _rotationSpeed)

func ClimbMovement(var delta, var moveDirection : Vector3):
	_velocity = Vector3.ZERO
	_velocity.y = -moveDirection.z * _climbSpeed

func _process(delta):
	_springArm.translation = translation

func OnCollectibleEntered(area):
	if(area.is_in_group("Coin")):
			area.get_parent().queue_free()
			print("coin")

func ChangeMovementSpeed(var isHolding : bool):
	if(isHolding):
		_currentSpeed = _carrySpeed
	else:
		_currentSpeed = _movementSpeed
