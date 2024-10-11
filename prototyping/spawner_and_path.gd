extends Path2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


var enemy_scene = preload("res://prototyping/enemy_prototype.tscn")
func _on_spawner_timer_timeout() -> void:
	print("spawning")
	var enemy = enemy_scene.instantiate()
	enemy.create(self)
	add_child(enemy)

# ex: set noexpandtab :
