extends Area2D
class_name HurtboxComponent

@export var health_component_node: HealthComponent

func _ready() -> void:
	assert(health_component_node != null, 
		   "Hurtbox compoents require health components to function properly.")
