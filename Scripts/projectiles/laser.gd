extends Area2D

@export var speed: int = 1000
@export var body_entered_reciever = ""
var direction: Vector2
func _ready():
	$DespawnTimer.start()


func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	print("Hit registered agaisn't Collidor:")
	print(body)
	
	if body.has_node(body_entered_reciever):
		var _body = body.get_node(body_entered_reciever)
		_body.on_body_entered(self)
		
	queue_free()


func _on_despawn_timer_timeout():
	queue_free()
