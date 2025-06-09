extends RigidBody2D

var ttl = 2

func _physics_process(delta: float) -> void:
	if ttl < 0:
		queue_free()
	ttl -= delta

func get_collision_radius() -> float:
	return $CollisionShape2D.shape.radius
