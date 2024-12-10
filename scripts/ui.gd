extends Node2D


var towerScript = preload("res://scripts/tower.gd").new()
@onready var towerScene = preload("res://scenes/tower.tscn")
var placeToggle = false

@export var coins = 50
var activeButton
var towerClasses = towerScript.TowerClasses
var towerClass = towerClasses.SKELETON
var selected = false
var canPlace = false
var curWave: int = 0


func _physics_process(_delta: float):
	$Coins.text = "Coins: " + str(coins)
	if not selected: return
	$SelectionCircle.global_position = get_global_mouse_position()
	$SelectionCircle/Area2D/CollisionShape2D.shape = CircleShape2D.new()
	$SelectionCircle/Area2D/CollisionShape2D.shape.radius = towerScript.towerClassStats[towerClass]["Bounding Radius"]
	canPlace = true
	for area in $SelectionCircle/Area2D.get_overlapping_areas():
		if not area.is_in_group("unclickable"): continue
		canPlace = false

	queue_redraw()


func _draw():
	if not selected: return
	var color = Color(Color.GREEN, 0.2)
	if not canPlace: color = Color(Color.RED, 0.2)
	draw_circle(get_global_mouse_position(), towerScript.towerClassStats[towerClass]["Detection Radius"], color)


func _input(event: InputEvent):
	if placeToggle and canPlace and event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		var tower = towerScene.instantiate()
		get_tree().get_root().add_child(tower)
		tower.create(event.position, towerClass, self)
		tower.position = get_global_mouse_position()

		activeButton.release_focus()
		placeToggle = false
		selected = false
		canPlace = false
		coins -= towerScript.towerClassStats[towerClass]["Cost"]
		queue_redraw()

	elif placeToggle and event is InputEventMouseButton:
		activeButton.release_focus()
		placeToggle = false


func _on_skeleton_button_pressed() -> void:
	if towerScript.towerClassStats[towerClass]["Cost"] > coins:
		$Skeleton/SkeletonButton.release_focus()
		return
	placeToggle = !placeToggle
	activeButton = $Skeleton/SkeletonButton
	towerClass = towerClasses.SKELETON
	selected = true


func _on_lizard_button_pressed() -> void:
	if towerScript.towerClassStats[towerClass]["Cost"] > coins:
		$Lizard/LizardButton.release_focus()
		return
	placeToggle = !placeToggle
	activeButton = $Lizard/LizardButton
	towerClass = towerClasses.LIZARD
	selected = true


func _on_ogre_button_pressed() -> void:
	if towerScript.towerClassStats[towerClass]["Cost"] > coins:
		$Ogre/OgreButton.release_focus()
		return
	placeToggle = !placeToggle
	activeButton = $Ogre/OgreButton
	towerClass = towerClasses.OGRE
	selected = true


func _on_play_button_pressed() -> void:
	curWave += 1
	get_parent().get_node("Randomized Path").waves()
	$WaveLabel.text = "Waves: " + str(curWave)
