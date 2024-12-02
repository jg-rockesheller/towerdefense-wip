# script by jason

extends Area2D


@onready var bulletScene = preload("res://scenes/bullet.tscn")


var enemyQueue = []
var curEnemy


func create(clickPos: Vector2) -> void:
	self.position = clickPos
	print(self.position)
	print(get_parent())


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
	var tempBullet = bulletScene.instantiate()
	add_child(tempBullet)
	tempBullet.create(curEnemy)
