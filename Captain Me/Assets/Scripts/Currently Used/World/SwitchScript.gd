extends Spatial

var _isActivated : bool = false
export var _activeMaterial : Material

func OnPlayerEnter(body):
	if(body.name == "Player"):
		$Model.material_override = _activeMaterial
		_isActivated = true
