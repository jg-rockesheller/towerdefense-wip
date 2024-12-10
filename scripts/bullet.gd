extends CharacterBody2D


var target
var damage
var speed: float = 200


func _physics_process(_delta: float) -> void:
	move_and_slide()
	if target == null: return
	velocity = global_position.direction_to(target.global_position) * speed
	look_at(target.global_position)


func create(inpEnemy, inpDamage) -> void:
	target = inpEnemy
	damage = inpDamage


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"): return
	area.get_parent().hit(damage)
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
