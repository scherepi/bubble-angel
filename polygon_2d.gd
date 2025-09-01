extends Polygon2D

var currentRadius = 70
var reset = false

func createCircle(radius: float, resolution: int) -> void:
	var interval = (2 * PI) / resolution
	var newCircle := PackedVector2Array() # temp array needed to store points
	for i in range(resolution):
		var vertex = Vector2(cos(interval * i), sin(interval * i)) * radius
		newCircle.append(vertex)
		#print(polygon)
	self.polygon = newCircle # has to be fully reassigned
 
func _ready() -> void:
	print("Creating polygon")
	createCircle(currentRadius, 32)

func _process(delta: float) -> void:
	if get_parent().is_on_floor():
		reset = true
	if get_parent().velocity.y < 0:
		createCircle(0, 0)
		reset = false
		return
	if reset:
		var newRadius: float = get_parent().velocity.y * 0.2
		if newRadius != currentRadius:
			currentRadius = newRadius
			createCircle(currentRadius + 70, 32) 
