class_name Player
extends RigidBody2D

static var player_packed_scene = preload("res://objects/player.tscn")
enum colors {BLUE, CYAN, GREEN, ORANGE, PINK, PURPLE, RED, WHITE, YELLOW, ADMIN}

var angle: float
var id: int


static func new_player(player_id: int, starting_position: Vector2, color: int = -1, is_main: bool = false) -> Array:
	var player = player_packed_scene.instantiate()
	player.id = player_id
	player.position = starting_position
	color = randi() % colors.size()-1 if color == -1 else color
	player.select_sprite(color)
	if is_main:
		var camera = Camera2D.new()
		player.add_child(camera)
		var action_component = PlayerActionComponent.new()
		player.add_child(action_component)
		return [player, action_component]
	return [player, null]


func update_angle(new_angle: float) -> void:
	angle = new_angle
	$Sprite.rotation = angle


func get_collision_radius() -> float:
	return $PlayerCollisionShape2D.shape.radius


func select_sprite(color: int) -> void:
	match color:
		colors.BLUE:
			set_sprite("res://objects/assets/blue_tank.png")
		colors.CYAN:   
			set_sprite("res://objects/assets/cyan_tank.png")
		colors.GREEN:  
			set_sprite("res://objects/assets/green_tank.png")
		colors.ORANGE: 
			set_sprite("res://objects/assets/orange_tank.png")
		colors.PINK:   
			set_sprite("res://objects/assets/pink_tank.png")
		colors.PURPLE: 
			set_sprite("res://objects/assets/purple_tank.png")
		colors.RED:    
			set_sprite("res://objects/assets/red_tank.png")
		colors.WHITE:  
			set_sprite("res://objects/assets/white_tank.png")
		colors.YELLOW: 
			set_sprite("res://objects/assets/yellow_tank.png")
		colors.ADMIN:  
			set_sprite("res://objects/assets/admin_tank.png")

func set_sprite(path: String) -> void:
	$Sprite.texture = load(path)
