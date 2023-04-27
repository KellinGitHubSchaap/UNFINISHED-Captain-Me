extends MeshInstance

export var _stateDown : Vector3
export var _stateUp : Vector3

var _nextStatePosition : Vector3

var _isMoving : bool = false
var _movementSpeed : float = 15.0 

func _ready():
	_nextStatePosition = _stateDown

func _process(delta):
	if(!_isMoving && translation == _nextStatePosition):
		return
	else:
		translation = translation.move_toward(_nextStatePosition, delta * _movementSpeed)
		if(translation.distance_to(_nextStatePosition) < 0.02):
			_isMoving = false
			translation = _nextStatePosition

func MouseInteractionTriggered():
	_isMoving = true
	print("Click")
	if(_nextStatePosition == _stateDown):
		_nextStatePosition = _stateUp
		return
	elif(_nextStatePosition == _stateUp):
		_nextStatePosition = _stateDown
		return

