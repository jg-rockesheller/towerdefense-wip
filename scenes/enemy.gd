extends PathFollow2D

@export var health = 25
@export var speed = 75

func _process(delta: float) -> void:
	if progress_ratio == 1 or health <= 0: queue_free()
	progress += speed * delta
func hit(damage:float): health -= damage

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
