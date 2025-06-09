extends Node2D

const blowback_distance: float = 70

var main_player_angle = 0


func _input(event: InputEvent) -> void:
	# Main player changes angle
	if event is InputEventMouseMotion:
		update_main_player_angle()
		return
	
	# Main player shoots 
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		main_player_shoot()
		return
	
	# debug
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		print($MainPlayer.velocity)


func get_main_player_tank_angle() -> float:
	var direction_vector = (get_global_mouse_position() - $MainPlayer.position).normalized()
	return direction_vector.angle()


func update_main_player_angle() -> void:
	main_player_angle = get_main_player_tank_angle()
	$MainPlayer.update_angle(main_player_angle)


func main_player_shoot():
	update_main_player_angle()
	var blowback_direction_vector = -Vector2.from_angle(main_player_angle)
	var new_pos = $MainPlayer.get_target_pos() \
				  + (blowback_direction_vector * blowback_distance)
	$MainPlayer.add_to_target_pos(new_pos)
