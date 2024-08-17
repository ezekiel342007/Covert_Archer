extends CharacterBody2D

@export var health: int = 100
@export var enemy_node: Node


func _ready():
	for enemy in enemy_node.get_children():
		if enemy.name == "TNTGoblin":
			enemy.has_exploded.connect(on_has_exploded)
	

func on_has_exploded(damage: int) -> void:
	health -= damage
	print("taken damage")