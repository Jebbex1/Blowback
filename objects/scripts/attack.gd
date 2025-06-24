extends Node2D
class_name Attack


static var attack_packed_scene = preload("res://objects/attack.tscn")

var damage: Dictionary[int, int] = {}


static func new_attack(physical_damage: int = 0) -> Attack:
    var attack = attack_packed_scene.instantiate()
    attack.damage[HealthComponent.DamageTypes.PHYSICAL] = physical_damage
    return attack
    