extends Area2D

var enemy: Node2D = null
@export var enemy_queue: Array[Area2D] = []
var bullet: PackedScene = preload("res://prototyping/bullet.tscn")

func _process(_delta):
	if enemy == null: return

func _on_detection_radius_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"): return
	if enemy != null:
		enemy_queue += [area.get_parent()]
		print(enemy_queue)
		return

	enemy = area.get_parent()
	$ReloadTimer.start()
	var newBullet = bullet.instantiate()
	newBullet.create(position, enemy)


func _on_detection_radius_area_exited(area: Area2D) -> void:
	if area.get_parent() in enemy_queue:
		enemy_queue.erase(area.get_parent())
		return

	enemy = enemy_queue.pop_front()
