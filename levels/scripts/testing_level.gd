extends Node2D

@export var blowback_impulse_magnitude: float = 700

var main_tank: Player


func _ready() -> void:
	add_tank(1, Vector2(0, -10), Player.colors.ADMIN, true)
	add_tank(2, Vector2(100, 100))


func add_tank(id: int, starting_position: Vector2, color: int = -1, is_main: bool = false):
	var player_set = Player.new_player(id, starting_position, color, is_main)
	if is_main:
		assert(main_tank == null, "Added two main tanks to the same scene - how u do this?")
		main_tank = player_set[0]
		var action_component = player_set[1]
		action_component.connect("player_updated_angle", main_player_refresh_angle)
		action_component.connect("player_shot", main_player_shoot)
	add_child(player_set[0])


func get_main_player_tank_angle() -> float:
	return (get_global_mouse_position() - main_tank.position).normalized().angle()


func main_player_refresh_angle() -> void:
	main_tank.update_angle(get_main_player_tank_angle())


func main_player_shoot():
	main_player_refresh_angle()
	var facing = Vector2.from_angle(get_main_player_tank_angle())
	var blowback_impulse = -facing * blowback_impulse_magnitude
	main_tank.apply_central_impulse(blowback_impulse)
	
	var bullet = Bullet.new_bullet()
	bullet.position = main_tank.position \
					  + 1.1*facing*main_tank.get_collision_radius() \
					  + 1.1*facing*bullet.get_collision_radius()
	add_child(bullet)
	bullet.apply_central_impulse(facing * blowback_impulse_magnitude)
	bullet.start_timeout()
