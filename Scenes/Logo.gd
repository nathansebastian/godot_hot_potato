extends Sprite2D

var pos: Vector2 = Vector2.ZERO # (0,0)
var test_scale: float = 0.5
const speed: int = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	print($"..".test_array)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	
	
	
