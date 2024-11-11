extends Path2D


@onready var enemyScene = preload("res://prototype/enemy_prototype.tscn")


func _on_timer_timeout() -> void:
	var tempEnemy = enemyScene.instantiate()
	add_child(tempEnemy)
