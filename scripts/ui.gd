# script by kunwoo

extends Node2D

@onready var towerScene = preload("res://scenes/tower.tscn")
var placeToggle = false


# section by jason [[[
var activeButton
enum TowerClasses {SKELETON, LIZARD, OGRE}
@export var towerClass: TowerClasses
# section by jason ]]]


func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		var evLocal = make_input_local(event)
		if placeToggle:
			var tower = towerScene.instantiate()
			get_tree().get_root().add_child(tower)
			tower.create(event.position, towerClass)
			tower.position = get_global_mouse_position()

			activeButton.release_focus()
			placeToggle = false


# section by jason [[[
func _on_skeleton_button_pressed() -> void:
	placeToggle = !placeToggle
	activeButton = $Skeleton/SkeletonButton
	towerClass = TowerClasses.SKELETON


func _on_lizard_button_pressed() -> void:
	placeToggle = !placeToggle
	activeButton = $Lizard/LizardButton
	towerClass = TowerClasses.LIZARD


func _on_ogre_button_pressed() -> void:
	placeToggle = !placeToggle
	activeButton = $Ogre/OgreButton
	towerClass = TowerClasses.OGRE
# section by jason ]]]
