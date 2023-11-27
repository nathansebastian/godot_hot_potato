extends CharacterBody2D

@export var health: int = 10


func _process(delta):
	
	var direction = Vector2.RIGHT
	velocity = direction * 400
	move_and_slide()
	
func hit(sender):
	health -= 4
	if health < 0:
		queue_free()
	
