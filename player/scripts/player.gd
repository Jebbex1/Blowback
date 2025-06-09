extends CharacterBody2D

var angle: float = 0


func _physics_process(delta):
	var weight = 1 - exp(-10 * delta)
	position = position.lerp($TargetPosition2D.position, weight)


func update_angle(new_angle: float) -> void:
	angle = new_angle
	$PlayerSprite2D.rotation = angle


func get_target_pos() -> Vector2:
	return $TargetPosition2D.position

func add_to_target_pos(new_pos: Vector2):
	$TargetPosition2D.position =+ new_pos
