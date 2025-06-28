extends RigidBody2D
class_name Tank

static var blowback_impulse_magnitude := 700
static var tank_packed_scene = preload("res://objects/tank.tscn")


var angle: float
var id: int

signal tank_health_depleted(id: int)


static func new_tank(tank_id: int, starting_position: Vector2, color: int = -1, is_main: bool = false) -> Array:
	var tank = tank_packed_scene.instantiate()
	tank.id = tank_id
	tank.position = starting_position
	# if the color of the tank was not selected, roll a random color (excluding the admin color)
	color = randi() % (TankSpriteComponent.sprite_colors.size()-1) if color == -1 else color
	tank.select_sprite_color(color)
	if is_main:
		var camera = Camera2D.new()
		tank.add_child(camera)
		var action_component = MainTankActionComponent.new()
		tank.add_child(action_component)
		return [tank, action_component]
	return [tank, null]


func _ready() -> void:
	$HealthComponent.connect("health_depleted", emit_died)


func emit_died() -> void:
	emit_signal("tank_health_depleted", id)


func update_angle(new_angle: float) -> void:
	angle = new_angle
	$TankSpriteComponent.rotation = angle


func select_sprite_color(color: int) -> void:
	$TankSpriteComponent.select_sprite_color(color)


func get_collision_radius() -> float:
	return $EnviromentCollisionShape.shape.radius
