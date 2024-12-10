extends PathFollow2D


@export var health = 25
@export var speed = 50
var coinsOnKill = 5


func _process(delta: float) -> void:
	if progress_ratio == 1:
		get_parent().get_parent().get_parent().get_node("UI").health -= health * 0.25
		queue_free()
	progress += speed * delta


func hit(damage:float):
	health -= damage
	if health <= 0: die()


func die():
	get_parent().get_parent().get_parent().get_node("UI").coins += coinsOnKill
	queue_free()



enum EnemyClasses {Ryder, Bomb, Sprint, Regular}
var enemyClass: EnemyClasses


@onready var enemyClassStats = {
	EnemyClasses.Ryder: {
		"Ability": true,
		"Extra Speed":   3,
		"Extra Health": 5,
		"Node":             $"Node2D/Ryder Davit",
	},
	EnemyClasses.Bomb: {
		"Ability": true,
		"Extra Speed":   1,
		"Extra Health": -2,
		"Node":             $"Node2D/Bomb Davit",
	},
	EnemyClasses.Sprint: {
		"Ability": false,
		"Extra Speed":   5,
		"Node":             $"Node2D/Speedy Davit",
	},
	EnemyClasses.Regular: {
		"Ability": false,
		"Extra Speed":   0,
		"Node":             $"Node2D/Regular Davit",
	},
}
