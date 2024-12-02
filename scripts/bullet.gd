extends CharacterBody2D


var target
@export var damage = 25


func _physics_process(_delta: float) -> void:
	move_and_slide()
	if target == null: return
	velocity = global_position.direction_to(target.global_position) * 500
	look_at(target.global_position)


func create(inpEnemy) -> void:
	target = inpEnemy
	print("test change")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Enemy" not in body.name: return
	body.get_parent().hit(damage)
	queue_free()
