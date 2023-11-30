extends CharacterBody2D

@export var health:int = 10 
var player_visible:bool = false
var can_laser:bool = true
var right_gun_use:bool = true
signal laser(pos,direction)

func private_set(val) -> void:
	pass

func _ready():
	pass

func _process(_delta):
	if(player_visible):
		#var tween = get_tree().create_tween()
		#tween.tween_property(self,"rotation",indoor_zoom,1)
		look_at(Globals.player_position)
		if can_laser:
			var marker_node  = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos,direction)
			can_laser = false
			$LaserCooldown.start()

func hit(sender):
	health -= 4
	if health < 0:
		queue_free()
		
func _on_attack_area_body_entered(body):
	player_visible = true 


func _on_attack_area_body_exited(body):
	player_visible = false 


func _on_laser_cooldown_timeout():
	can_laser = true
