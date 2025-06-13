extends Area2D
class_name HurtboxComponent

@export var health_component_node: HealthComponent = null

func _ready() -> void:
	set_monitoring(true)
