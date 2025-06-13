extends RigidBody2D

var angle: float = 0
var id = -1


func update_angle(new_angle: float) -> void:
	angle = new_angle
	$PlayerSprite2D.rotation = angle


func get_target_pos() -> Vector2:
	return $TargetPosition2D.position


func add_to_target_pos(new_pos: Vector2):
	$TargetPosition2D.position =+ new_pos


func get_collision_radius() -> float:
	return $PlayerCollisionShape2D.shape.radius


func update_sprite(path: String):
	$PlayerSprite2D.texture = load(path)


func give_camera():
	add_child(Camera2D.new())
