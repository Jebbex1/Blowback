extends RigidBody2D
class_name Bullet

static var bullet_packed_scene = preload("res://objects/bullet.tscn")


static func new_bullet() -> Bullet:
	var bullet = bullet_packed_scene.instantiate()
	return bullet


func _ready() -> void:
	$TTLComponent.timeout.connect(queue_free)


func get_collision_radius() -> float:
	return $CollisionShape2D.shape.radius


func start_timeout() -> void:
	$TTLComponent.start()


func _on_hitbox_body_collision(body: Node2D) -> void:
	if body is Tank or body is StaticBody2D:
		queue_free()
