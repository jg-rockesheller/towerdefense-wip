extends Node2D

# TODO - fix enemy_prototype
# @export var enemy_prototype: Node2D
# var bullet_speed = 2
# var velocity = 0
# var last_direction
# var enemy_queue
# 
# 
# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(_delta: float):
# 	if is_instance_valid(enemy_prototype) or enemy not in enemy_queue:
# 		last_direction = position.direction_to(enemy_prototype.position)
# 	position += last_direction * bullet_speed
# 
# func create(tower_pos, enemy, enemy_queue):
# 	position = tower_pos
# 	enemy_prototype = enemy
# 	last_direction = position.direction_to(enemy_prototype.position)
# 
# 
# func _on_area_2d_area_entered(area: Area2D) -> void:
# 	if area.is_in_group("enemy"):
# 		enemy_prototype.explode()
# 		queue_free()
