extends RigidBody2D
class_name Bullet

@export var base_damage := 10
@export var effective_ttl := 0.7

static var blowback_impulse_magnitude := 700
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
	assert(effective_ttl <= $TTLComponent.time_left,
		   "The bullet's effective range (in time) can't be longer than the total time the bullet exists.")


func _on_hitbox_body_collision(body: Node2D) -> void:
	if body is Tank or body is StaticBody2D:
		queue_free()


func get_damage() -> int:
	var ttl = $TTLComponent.time_left

	if  ttl <= 0:
		return 0

	if ttl >= effective_ttl:
		return base_damage

	return ttl*(base_damage/effective_ttl)
