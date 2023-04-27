extends KinematicBody

var _gravity : float = 650.0
var _throwStrength : float = 40.0

var _velocity : Vector3 = Vector3.ZERO

var _isThrown : bool = false

onready var _playerFacingDir : KinematicBody = get_node("../../Player")

func _physics_process(delta):
	if(_isThrown):
		_velocity = _playerFacingDir._model.global_transform.basis.y * _throwStrength
		_velocity.y -= _gravity * delta
		_velocity = move_and_slide(_velocity,Vector3.UP)

func OnCollision(body):
	if(body.name != "Player" && _isThrown):
		queue_free()
		print("value")
