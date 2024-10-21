extends Node2D

# TODO - fix enemy_prototype
@export var enemy_prototype: Node2D
var bullet_speed = 2
var velocity = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	position += position.direction_to(enemy_prototype.position) * bullet_speed

func create(tower_pos, enemy: Node2D):
	enemy_prototype = enemy
	position = tower_pos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		enemy_prototype.explode()
		queue_free()
