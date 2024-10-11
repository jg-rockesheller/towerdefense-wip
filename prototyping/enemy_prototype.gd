extends PathFollow2D


@export var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progress_ratio == 1:
		path_node.damage(10)
		queue_free()
	progress += speed * delta


@export var path_node: Path2D
func create(inp_node):
	path_node = inp_node


# ex: set noexpandtab :
