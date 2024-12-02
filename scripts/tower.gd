# script by kunwoo

extends Area2D


@onready var arrowScene = preload("res://scenes/arrow.tscn")


# section by jason [[[
enum TowerClasses {SKELETON, LIZARD, OGRE}
var towerClass: TowerClasses

@onready var towerClassStats = {
	TowerClasses.SKELETON: {
		"Detection Radius": 92,
		"Bounding Radius":  10,
		"Recharge Timer":   3,
		"Node":             $Skeleton,
	},
	TowerClasses.LIZARD: {
		"Detection Radius": 27.5,
		"Bounding Radius":  10,
		"Recharge Timer":   1,
		"Node":             $Lizard,
	},
	TowerClasses.OGRE: {
		"Detection Radius": 40,
		"Bounding Radius":  17.5,
		"Recharge Timer":   5,
		"Node":             $Ogre,
	},
}
# section by jason ]]]

var enemyQueue = []
var curEnemy


func create(clickPos: Vector2, inpClass: TowerClasses) -> void:
	self.position = clickPos
	print(self.position)
	print(get_parent())

	# section by jason [[[
	towerClass = inpClass
	$"Detection Shape".shape = CircleShape2D.new()
	$"Detection Shape".shape.radius = towerClassStats[towerClass]["Detection Radius"]
	$"Bounding Shape/CollisionShape2D".shape = CircleShape2D.new()
	$"Bounding Shape/CollisionShape2D".shape.radius = towerClassStats[towerClass]["Bounding Radius"]
	$Timer.wait_time = towerClassStats[towerClass]["Recharge Timer"]
	towerClassStats[towerClass]["Node"].visible = true
	# section by jason ]]]


func selectEnemy() -> void:
	if len(enemyQueue) == 0:
		curEnemy = null
		return

	var maxProgressIdx = 0
	for enemyIdx in enemyQueue.size():
		if enemyQueue[enemyIdx].get_parent().progress_ratio > enemyQueue[maxProgressIdx].get_parent().progress_ratio:
			maxProgressIdx = enemyIdx
	curEnemy = enemyQueue[maxProgressIdx]


func _on_body_entered(body: Node2D) -> void:
	if "Enemy" not in body.name: return
	enemyQueue.append(body)
	selectEnemy()


func _on_body_exited(body: Node2D) -> void:
	if body not in enemyQueue: return
	enemyQueue.erase(body)
	selectEnemy()


func _on_timer_timeout() -> void:
	if curEnemy == null: return
	attack()


# section by jason [[[
func attack() -> void:
	print(towerClass)
	match towerClass:
		TowerClasses.SKELETON:
			var tempArrow = arrowScene.instantiate()
			add_child(tempArrow)
			tempArrow.create(curEnemy)

func _on_bounding_shape_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not event.is_pressed(): return
	print("TODO: upgrading / removing tower")
# section by jason ]]]
