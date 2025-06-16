extends Node2D

@export var blowback_impulse_magnitude: float = 800

var main_tank: Tank


func _ready() -> void:
	add_tank(1, Vector2(0, -10), Tank.colors.ADMIN, true)
	add_tank(2, Vector2(100, 100))


func add_tank(id: int, starting_position: Vector2, color: int = -1, is_main: bool = false):
	var tank_set = Tank.new_tank(id, starting_position, color, is_main)
	if is_main:
		assert(main_tank == null, "Added two main tanks to the same scene - how u do this?")
		main_tank = tank_set[0]
		var action_component = tank_set[1]
		action_component.connect("tank_updated_angle", main_tank_refresh_angle)
		action_component.connect("tank_shot", main_tank_shoot)
	add_child(tank_set[0])


func get_main_tank_angle() -> float:
	return (get_global_mouse_position() - main_tank.position).normalized().angle()


func main_tank_refresh_angle() -> void:
	main_tank.update_angle(get_main_tank_angle())


func main_tank_shoot():
	main_tank_refresh_angle()
	var facing = Vector2.from_angle(get_main_tank_angle())
	var blowback_impulse = -facing * blowback_impulse_magnitude
	main_tank.apply_central_impulse(blowback_impulse)
	
	var bullet = Bullet.new_bullet()
	bullet.position = main_tank.position \
					  + 1.1*facing*main_tank.get_collision_radius() \
					  + 1.1*facing*bullet.get_collision_radius()
	add_child(bullet)
	bullet.apply_central_impulse(facing * blowback_impulse_magnitude)
	bullet.start_timeout()
