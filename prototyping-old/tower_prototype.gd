extends Area2D


var enemy_queue: Array = []
var bullet: PackedScene = preload("res://prototyping/bullet.tscn")


func _process(_delta):
	if len(enemy_queue) == 0: return


func _on_detection_radius_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"): return
	enemy_queue += enemy_queue + [area.get_parent()]

	if $ReloadTimer.time_left > 0: $ReloadTimer.start()


func _on_detection_radius_area_exited(area: Area2D) -> void:
	if area.get_parent() in enemy_queue: enemy_queue.erase(area.get_parent())


func _on_reload_timer_timeout() -> void:
	$ReloadTimer.start()
	# print(enemy_queue)
	# print(enemy_queue[0])
	# $ReloadTimer.start()
	# if len(enemy_queue) == 0: return

	# var newBullet = bullet.instantiate()
	# get_tree().root.add_child(newBullet)
	# newBullet.create(position, enemy_queue[0])
