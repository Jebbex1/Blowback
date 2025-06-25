extends Sprite2D
class_name TankSpriteComponent

enum sprite_colors {WHITE, RED, BLUE, GREEN, YELLOW, CYAN, PURPLE, ORANGE, PINK, ADMIN}
const spritesheet_locations = {
	sprite_colors.WHITE:  [0, 0],
	sprite_colors.RED:    [1, 0],
	sprite_colors.BLUE:   [2, 0],
	sprite_colors.GREEN:  [3, 0],
	sprite_colors.YELLOW: [0, 1],
	sprite_colors.CYAN:   [1, 1],
	sprite_colors.PURPLE: [2, 1],
	sprite_colors.ORANGE: [3, 1],
	sprite_colors.PINK:   [0, 2],
	sprite_colors.ADMIN:  [1, 2],
}

func select_sprite_color(color: int) -> void:
	var sprite_location_x = spritesheet_locations[color][0] * region_rect.size[0]
	var sprite_location_y = spritesheet_locations[color][1] * region_rect.size[1]
	region_rect.position.x = sprite_location_x
	region_rect.position.y = sprite_location_y
