extends Node

var _player 

onready var _snapTopPos = $"Top O Ladder/Snap To Ladder Top"
onready var _doneClimbingUpPos = $"Top O Ladder/Done Climbing Up Pos"

func PlayerIsAtFoot(body):
	if(body.name == "Player"):
		_player = body
		
		if(Input.is_action_pressed("forward")):
			_player._isClimbing = true
		elif(Input.is_action_pressed("backward")):
			_player._isClimbing = false

func PlayerIsAtTop(body):
	if(body.name == "Player"):
		_player = body
		
		if(Input.is_action_pressed("forward")):
			_player._isClimbing = false
			_player.translation = _doneClimbingUpPos.global_transform.origin
		elif(Input.is_action_pressed("backward")):
			_player._isClimbing = true
			_player.translation = _snapTopPos.global_transform.origin
