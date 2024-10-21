extends Area2D

var enemy: Node2D
var enemy_queue: Array[Area2D]

func _process():
	if not enemy: return

func _on_detection_radius_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"): return
	if enemy:
		enemy_queue.append(area.get_parent())
		return
	enemy = area.get_parent()

