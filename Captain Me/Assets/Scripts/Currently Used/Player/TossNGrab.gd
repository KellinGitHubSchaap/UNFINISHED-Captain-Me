extends Spatial

onready var _player = get_parent().get_parent()
onready var _interactionRay : RayCast = $RayCast

var _heldObject = null
var _holdOffset : Vector3 = Vector3(0, 3, 0)

func _process(delta):
	if(Input.is_action_just_pressed("interaction")):  
		if(_interactionRay.is_colliding() && _heldObject == null):
			GrabObject()
		elif(_heldObject != null):
			ThrowObject()

func GrabObject():
		_heldObject = _interactionRay.get_collider()
		var interactableNode = _heldObject.get_node("../../../Interactable")
		interactableNode.remove_child(_heldObject.get_parent())
		
		_player.get_node("Model/TossNGrab/HoldPos").add_child(_heldObject.get_parent())
		_heldObject.get_parent().translation = _holdOffset
		_heldObject.get_parent().get_node("CollisionShape").disabled = true
		_player.ChangeMovementSpeed(true)

func ThrowObject():
	_heldObject.get_parent().get_node("CollisionShape").disabled = true
	_heldObject.get_parent()._isThrown = true
	_heldObject = null
