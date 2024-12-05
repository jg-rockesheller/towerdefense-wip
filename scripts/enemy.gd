extends PathFollow2D


@export var health = 50
@export var speed = 75


func _process(delta: float) -> void:
	if progress_ratio == 1 or health <= 0: queue_free()
	progress += speed * delta


func hit(damage: float): health -= damage
