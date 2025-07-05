extends Node2D
class_name AbstractMap

var team_respawn_map: Dictionary[String, Array] = {}


func _ready() -> void:
	initialize_respawn_point_map()


func initialize_respawn_point_map() -> void:
	for child in get_children():
		if child is RespawnPointComponent:
			var r_point := child as RespawnPointComponent
			if not r_point.team_name in team_respawn_map.keys():
				team_respawn_map[r_point.team_name] = []
			team_respawn_map[r_point.team_name].append(Vector2(r_point.position))
