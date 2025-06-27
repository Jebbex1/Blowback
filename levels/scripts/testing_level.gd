extends Node2D

var main_tank: Tank
var loaded_tanks: Dictionary[int, Tank] = {}


func _ready() -> void:
	add_tank(1, Vector2(0, -10), TankSpriteComponent.sprite_colors.ADMIN, true)
	add_tank(2, Vector2(100, 100))


func add_tank(id: int, starting_position: Vector2, color: int = -1, is_main: bool = false) -> void:
	var tank_set = Tank.new_tank(id, starting_position, color, is_main)
	if is_main:
		assert(main_tank == null, "Added two main tanks to the same scene - how u do this?")
		main_tank = tank_set[0]
		var action_component = tank_set[1]
		action_component.connect("tank_updated_angle", main_tank_refresh_angle)
		action_component.connect("tank_shot", main_tank_shoot)
	loaded_tanks[id] = tank_set[0]
	add_child(tank_set[0])
	tank_set[0].connect("tank_health_depleted", kill_tank)


func remove_tank(id: int) -> void:
	var tank = loaded_tanks[id]
	remove_child(tank)
	tank.queue_free()


func get_main_tank_angle() -> float:
	return (get_global_mouse_position() - main_tank.position).normalized().angle()


func main_tank_refresh_angle() -> void:
	main_tank.update_angle(get_main_tank_angle())


func tank_shoot(id: int) -> void:
	if not loaded_tanks.has(id):
		return
	
	var tank = loaded_tanks[id]
	var facing = Vector2.from_angle(tank.angle)
	tank.apply_central_impulse(-facing * Tank.blowback_impulse_magnitude)
	
	var bullet = Bullet.new_bullet()
	bullet.position = tank.position \
					  + 1.1*facing*tank.get_collision_radius() \
					  + 1.1*facing*bullet.get_collision_radius()
	
	add_child(bullet)
	bullet.apply_central_impulse(facing * Bullet.blowback_impulse_magnitude)
	bullet.start_timeout()


func main_tank_shoot() -> void:
	tank_shoot(main_tank.id)


func kill_tank(id: int) -> void:
	remove_tank(id)
