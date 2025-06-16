class_name Tank
extends RigidBody2D

static var tank_packed_scene = preload("res://objects/tank.tscn")
enum colors {BLUE, CYAN, GREEN, ORANGE, PINK, PURPLE, RED, WHITE, YELLOW, ADMIN}

var angle: float
var id: int


static func new_tank(tank_id: int, starting_position: Vector2, color: int = -1, is_main: bool = false) -> Array:
	var tank = tank_packed_scene.instantiate()
	tank.id = tank_id
	tank.position = starting_position
	# if the color of the tank was not selected, roll a random color (excluding the admin color)
	color = randi() % (colors.size()-1) if color == -1 else color
	tank.select_sprite(color)
	if is_main:
		var camera = Camera2D.new()
		tank.add_child(camera)
		var action_component = MainTankActionComponent.new()
		tank.add_child(action_component)
		return [tank, action_component]
	return [tank, null]


func update_angle(new_angle: float) -> void:
	angle = new_angle
	$Sprite.rotation = angle


func get_collision_radius() -> float:
	return $EnviromentCollisionShape.shape.radius


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
