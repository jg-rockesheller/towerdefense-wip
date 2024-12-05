extends Area2D


@onready var arrowScene = preload("res://scenes/arrow.tscn")


enum TowerClasses {SKELETON, LIZARD, OGRE}
var towerClass: TowerClasses
var damage: int
var canAttack: bool = true
var cooldownTime: float


@onready var towerClassStats = {
	TowerClasses.SKELETON: {
		"Detection Radius": 92,
		"Bounding Radius":  10,
		"Recharge Timer":   2,
		"Damage":           25,
		"Node":             $Skeleton,
	},
	TowerClasses.LIZARD: {
		"Detection Radius": 25,
		"Bounding Radius":  15,
		"Recharge Timer":   0.75,
		"Damage":           12.5,
		"Node":             $Lizard,
	},
	TowerClasses.OGRE: {
		"Detection Radius": 40,
		"Bounding Radius":  17.5,
		"Recharge Timer":   3,
		"Damage":           50,
		"Node":             $Ogre,
	},
}


var enemyQueue = []
var curEnemy


func create(clickPos: Vector2, inpClass: TowerClasses) -> void:
	self.position = clickPos

	towerClass = inpClass
	$"Detection Shape".shape = CircleShape2D.new()
	$"Detection Shape".shape.radius = towerClassStats[towerClass]["Detection Radius"]
	$"Bounding Shape/CollisionShape2D".shape = CircleShape2D.new()
	$"Bounding Shape/CollisionShape2D".shape.radius = towerClassStats[towerClass]["Bounding Radius"]
	damage = towerClassStats[towerClass]["Damage"]
	cooldownTime = towerClassStats[towerClass]["Recharge Timer"]
	$Timer.wait_time = cooldownTime
	towerClassStats[towerClass]["Node"].visible = true


func selectEnemy() -> void:
	if len(enemyQueue) == 0:
		curEnemy = null
		return

	var maxProgressIdx = 0
	for enemyIdx in enemyQueue.size():
		if enemyQueue[enemyIdx].get_parent().progress_ratio > enemyQueue[maxProgressIdx].get_parent().progress_ratio:
			maxProgressIdx = enemyIdx
	curEnemy = enemyQueue[maxProgressIdx]


func _on_timer_timeout() -> void:
	canAttack = true
	if curEnemy == null: return
	attack()


func _on_area_entered(area: Area2D) -> void:
	if "Enemy" not in area.name: return
	enemyQueue.append(area)
	selectEnemy()

	if canAttack == true: attack()


func _on_area_exited(area: Area2D) -> void:
	if area not in enemyQueue:
		if towerClass == TowerClasses.LIZARD: $Lizard/Pivot.rotation = 0
		return
	enemyQueue.erase(area)
	selectEnemy()


func attack() -> void:
	canAttack = false
	match towerClass:
		TowerClasses.SKELETON:
			$Skeleton/DrawBow.play("DrawBow")
			await Signal($Skeleton/DrawBow, "animation_finished")
			var tempArrow = arrowScene.instantiate()
			add_child(tempArrow)
			tempArrow.create(curEnemy, damage)
		TowerClasses.LIZARD:
			$Lizard/Pivot.look_at(curEnemy.global_position)
			$Lizard.flip_h = curEnemy.global_position.x < global_position.x
			$Lizard/LizardSwing.play("swing")
			await Signal($Lizard/LizardSwing, "animation_finished")
		TowerClasses.OGRE:
			$Ogre/Pivot.look_at(curEnemy.global_position)
			$Ogre.flip_h = curEnemy.global_position.x < global_position.x
			$Ogre/OgreSwing.play("swing")
			await Signal($Ogre/OgreSwing, "animation_finished")
			print("finished swing")
			$Ogre/Pivot.rotation = 0
	$Timer.start(cooldownTime)


func _on_bounding_shape_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_pressed(): return
	print("TODO: upgrading / removing tower")


func _on_knife_hitbox_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"): return
	area.get_parent().hit(damage)


func _process(_delta: float) -> void:
	if curEnemy == null: return
	if canAttack and not curEnemy == null: attack()
	if towerClass == TowerClasses.SKELETON:
		$Skeleton/Pivot.look_at(curEnemy.global_position)
		$Skeleton.flip_h = curEnemy.global_position.x < global_position.x


func _on_battle_axe_hitbox_area_entered(area: Area2D) -> void:
	if not area.is_in_group("enemy"): return
	area.get_parent().hit(damage)
