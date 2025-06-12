extends Node2D
class_name HealthComponent

@export var health = 100

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


func _on_health_changed(amount: int) -> void:
	pass # Replace with function body.


func _on_health_decreased(amount: int) -> void:
	pass # Replace with function body.


func _on_health_depleted() -> void:
	pass # Replace with function body.


func _on_health_increased(amount: int) -> void:
	pass # Replace with function body.
