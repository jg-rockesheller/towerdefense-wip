extends Node2D


var pathVectors: Array[Vector2]


func randomSection(tl: Vector2, br: Vector2) -> void:
	var pointsNum: int = randi_range(1, 4)
	var sectionLength: float = (br.x - tl.x) / pointsNum
	var rad: float = 75
	for i in range(1, pointsNum):
		var newPoint: Vector2 = Vector2(
			randi_range(tl.x + (sectionLength * (i - 1)), tl.x + (sectionLength * i)),
			randi_range(tl.y, br.y))
		
		for prevPoint in pathVectors.slice(len(pathVectors) - i, len(pathVectors) - 1):
			if newPoint.y < prevPoint.y + rad and newPoint.y > prevPoint.y - rad:
				newPoint = Vector2(
					randi_range(tl.x + (sectionLength * (i - 1)), tl.x + (sectionLength * i)),
					randi_range(tl.y, br.y))

		pathVectors.append(newPoint)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

	# rectangle range: (-460, -250) (185, 250)
	# tl: (-460, -250) (-137.5, 0)
	# bl: (-460, 0) (-137.5, 250)
	# tr: (-137.5, -250) (185, 0)
	# br: (-137.5, 0) (185, 250)

	if randi_range(1, 2) == 1:
		pathVectors.append(Vector2(-500, randf_range(-250, 0)))
		randomSection(Vector2(-460, -250), Vector2(-137.5, 0)) # tl
		randomSection(Vector2(-460, 0), Vector2(-137.5, 250))  # bl
		randomSection(Vector2(-137.5, 0), Vector2(185, 250))   # br
		randomSection(Vector2(-137.5, -250), Vector2(185, 0))  # tr
		pathVectors.append(Vector2(225, randf_range(-250, 0)))
	else:
		pathVectors.append(Vector2(-500, randf_range(250, 0)))
		randomSection(Vector2(-460, 0), Vector2(-137.5, 250))  # bl
		randomSection(Vector2(-460, -250), Vector2(-137.5, 0)) # tl
		randomSection(Vector2(-137.5, -250), Vector2(185, 0))  # tr
		randomSection(Vector2(-137.5, 0), Vector2(185, 250))   # br
		pathVectors.append(Vector2(225, randf_range(250, 0)))

	for point in pathVectors:
		print(point)
		$Line2D.add_point(point)
		$Path2D.curve.add_point(point)

	for i in pathVectors.size() - 1:
		# taken from https://kidscancode.org/godot_recipes/4.x/2d/line_collision/
		var new_shape = CollisionShape2D.new()
		$Area2D.add_child(new_shape)
		var segment = SegmentShape2D.new()
		segment.a = pathVectors[i]
		segment.b = pathVectors[i + 1]
		new_shape.shape = segment
