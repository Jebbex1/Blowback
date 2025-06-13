extends RigidBody2D
class_name Bullet


func get_collision_radius() -> float:
	return $CollisionShape2D.shape.radius


func _on_body_collision(body: Node2D) -> void:
	if body is Player or body is StaticBody2D:
		queue_free()


func _on_ttl_timeout() -> void:
	queue_free()
