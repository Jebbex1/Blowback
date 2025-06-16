extends Node2D
class_name MainTankActionComponent

signal tank_shot()
signal tank_updated_angle()


func _input(event: InputEvent) -> void:
	# Main tank changes angle
	if event is InputEventMouseMotion:
		emit_signal("tank_updated_angle")
		return
	
	# Main tank shoots 
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("tank_shot")
		return
