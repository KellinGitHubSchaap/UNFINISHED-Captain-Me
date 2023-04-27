extends Spatial

# Moveable Objects
signal interaction

func _unhandled_input(event):
	if(event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		if(event.is_pressed()):
			var rayLength = 1000
			var camera = get_node("Player/SpringArm/Camera")
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * rayLength
			var spaceState = get_world().get_direct_space_state()
			var result = spaceState.intersect_ray(from, to)
			
			if(result.collider.get_parent().is_in_group("InteractableByMouse")):
				result.collider.get_parent().MouseInteractionTriggered()
