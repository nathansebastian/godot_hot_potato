extends CharacterBody2D

var player_visible:bool = false
var can_laser:bool = true

signal laser(pos,direction)

func _ready():
	pass

func _process(_delta):
	if(player_visible):
		#var tween = get_tree().create_tween()
		#tween.tween_property(self,"rotation",indoor_zoom,1)
		look_at(Globals.player_position)
		if(can_laser):
			var pos: Vector2
			var direction: Vector2
			laser.emit(pos,direction)
			can_laser = false
			$LaserCooldown.start()

func _on_attack_area_body_entered(body):
	player_visible = true 


func _on_attack_area_body_exited(body):
	player_visible = false 


func _on_laser_cooldown_timeout():
	can_laser = true
