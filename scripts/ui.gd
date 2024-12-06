extends Node2D


var towerScript = preload("res://scripts/tower.gd").new()
@onready var towerScene = preload("res://scenes/tower.tscn")
var placeToggle = false


var activeButton
var towerClasses = towerScript.TowerClasses
var towerClass = towerClasses.SKELETON
var selected = false
var canPlace = false


func _physics_process(_delta: float):
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
	if canPlace and event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		if placeToggle:
			var tower = towerScene.instantiate()
			get_tree().get_root().add_child(tower)
			tower.create(event.position, towerClass)
			tower.position = get_global_mouse_position()

			activeButton.release_focus()
			placeToggle = false
			selected = false
			canPlace = false
			queue_redraw()


func _on_skeleton_button_pressed() -> void:
	placeToggle = !placeToggle
	activeButton = $Skeleton/SkeletonButton
	towerClass = towerClasses.SKELETON
	selected = true


func _on_lizard_button_pressed() -> void:
	placeToggle = !placeToggle
	activeButton = $Lizard/LizardButton
	towerClass = towerClasses.LIZARD
	selected = true


func _on_ogre_button_pressed() -> void:
	placeToggle = !placeToggle
	activeButton = $Ogre/OgreButton
	towerClass = towerClasses.OGRE
	selected = true
