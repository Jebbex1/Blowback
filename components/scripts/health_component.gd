extends Node2D
class_name HealthComponent

@export var health = 100
@export var physical_defence := 0

enum DamageTypes {PHYSICAL}

signal health_changed(amount: int)
signal health_increased(amount: int)
signal health_decreased(amount: int)
signal health_depleted()


func get_health() -> int:
	return health


func increase_health(amount: int) -> void:
	assert(amount > 0)
	health += amount
	emit_signal("health_changed", amount)
	emit_signal("health_increased", amount)


func decrease_health(amount: int) -> void:
	assert(amount > 0)
	health -= amount
	emit_signal("health_changed", -amount)
	emit_signal("health_decreased", amount)
	
	if health <= 0:
		emit_signal("health_depleted")


func calculate_health_decrease(attack: Attack) -> int:
	var total_health_decrease = 0
	if attack.damage[DamageTypes.PHYSICAL] - physical_defence > 0:
		total_health_decrease += attack.damage[DamageTypes.PHYSICAL] - physical_defence
	return total_health_decrease


func hurt(attack: Attack) -> void:
	var damage = calculate_health_decrease(attack)
	if damage > 0:
		decrease_health(damage)
