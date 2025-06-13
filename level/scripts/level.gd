extends Node2D

enum colors {BLUE, CYAN, GREEN, ORANGE, PINK, PURPLE, RED, WHITE, YELLOW, ADMIN}
const color_paths = {
	colors.BLUE:   "res://player/assets/blue_tank.png", 
	colors.CYAN:   "res://player/assets/cyan_tank.png",
	colors.GREEN:  "res://player/assets/green_tank.png",
	colors.ORANGE: "res://player/assets/orange_tank.png",
	colors.PINK:   "res://player/assets/pink_tank.png",
	colors.PURPLE: "res://player/assets/purple_tank.png",
	colors.RED:    "res://player/assets/red_tank.png",
	colors.WHITE:  "res://player/assets/white_tank.png",
	colors.YELLOW: "res://player/assets/yellow_tank.png",
	colors.ADMIN:  "res://player/assets/admin_tank.png",
}

@export var blowback_impulse_magnitude: float = 700
@export var bullet_preload = preload("res://bullet/bullet.tscn")
@export var player_preload = preload("res://player/player.tscn")


var loaded_tanks = {}
var main_tank = null


func _ready() -> void:
	add_tank(1, Vector2(100, 100), 2)
	add_tank(1, Vector2(100, 200), colors.ADMIN, true)


func _input(event: InputEvent) -> void:
	# Main player changes angle
	if event is InputEventMouseMotion:
		update_main_player_angle()
		return
	
	# Main player shoots 
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		main_player_shoot()
		return


func get_main_player_tank_angle() -> float:
	var direction_vector = (get_global_mouse_position() - main_tank.position).normalized()
	return direction_vector.angle()


func update_main_player_angle() -> void:
	main_tank.update_angle(get_main_player_tank_angle())


func main_player_shoot():
	update_main_player_angle()
	var facing = Vector2.from_angle(get_main_player_tank_angle())
	var blowback_impulse = -facing * blowback_impulse_magnitude
	main_tank.apply_central_impulse(blowback_impulse)
	
	var bullet = bullet_preload.instantiate()
	bullet.position = main_tank.position + 1.1*facing*main_tank.get_collision_radius() + 1.1*facing*bullet.get_collision_radius()
	add_child(bullet)
	bullet.apply_central_impulse(facing * blowback_impulse_magnitude)


func add_tank(id: int, position: Vector2, color: int, is_main: bool = false):
	var player = player_preload.instantiate()
	player.id = id
	player.update_sprite(color_paths[color])
	player.position = position
	
	if is_main:
		main_tank = player
		player.give_camera()
	
	add_child(player)
	loaded_tanks[id] = player
