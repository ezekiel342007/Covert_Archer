extends Camera2D
class_name GameCamera

@export_category("Focus on") 
@export var focus: CharacterBody2D
@export_category("Transitioning")
@export var transition_speed: float = 3.0

signal transition_ended

var transition_target: Vector2
var transitioning: bool = false 


func _ready() -> void:
	unique_name_in_owner = true


func _physics_process(_delta: float) -> void:
	if focus != null:
		if transitioning == false:
			global_position = focus.global_position
		else:
			zoom = Vector2(1.7, 1.7)
			global_position = transition_target
			get_tree().create_tween().tween_property(self, "zoom", Vector2(1.0, 1.0), 2.5)
			await get_tree().create_timer(1.0).timeout
			var focus_tween: Tween = get_tree().create_tween()
			focus_tween.tween_property(self, "global_position", focus.global_position, 2.5)
			await focus_tween.finished
			focus_tween.kill()
			transitioning = false
			transition_ended.emit()


func transition_from(target: Vector2) -> void:
	transitioning = true
	transition_target = target
