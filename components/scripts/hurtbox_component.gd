extends Area2D
class_name HurtboxComponent

@export var health_component_node: HealthComponent

func _ready() -> void:
	assert(health_component_node != null, 
		   "Hurtbox compoents require health components to function properly.")


func _on_body_entered(body: Node2D) -> void:
	if not (body is Bullet):
		return
	var bullet := body as Bullet
	var damage = bullet.get_damage()
	var attack = Attack.new_attack(damage)
	damage = health_component_node.calculate_health_decrease(attack)
	health_component_node.decrease_health(damage)
