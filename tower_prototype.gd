extends Node2D
@export var bullet: PackedScene
var can_shoot = true

func _on_reload_timer_timeout() -> void:
	can_shoot = true

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$ReloadTimer.start()
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	
func _process(delta):
	pass
		
func _on_detection_radius_area_entered(area: Area2D) -> void:
	shoot()
