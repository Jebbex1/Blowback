extends Node2D
class_name PlayerActionComponent

signal player_shot()
signal player_updated_angle()


func _input(event: InputEvent) -> void:
	# Main player changes angle
	if event is InputEventMouseMotion:
		emit_signal("player_updated_angle")
		return
	
	# Main player shoots 
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("player_shot")
		return
