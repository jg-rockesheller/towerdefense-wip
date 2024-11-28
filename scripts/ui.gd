extends Node2D

var placeToggle = false
@onready var towerScene = preload("res://scenes/tower.tscn")

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		var evLocal = make_input_local(event)
		if placeToggle:
			var tower = towerScene.instantiate()
			get_tree().get_root().add_child(tower)
			tower.create(event.position)
			tower.position = get_global_mouse_position()

			$Sprite2D/Button.release_focus()
			placeToggle = false


func _on_button_toggled(toggled_on: bool) -> void:
	print(toggled_on)


func _on_button_pressed() -> void:
	placeToggle = !placeToggle
