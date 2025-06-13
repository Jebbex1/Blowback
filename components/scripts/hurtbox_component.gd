extends Area2D
class_name HurtboxComponent

@export var health_component_node: HealthComponent = null

func _ready() -> void:
	set_monitoring(true)


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		print("Hello")
