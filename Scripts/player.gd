extends CharacterBody2D

signal laser_shot(pos,direction)
signal grenade_thrown(pos,direction)
signal player_died()
var overwrite_mouse: bool = false
var last_mouse_position:Vector2
var can_laser: bool = true
var can_grenade: bool = true
@export var push_force: int

@export var max_speed: int = 500
var speed: int = max_speed

func _ready():
	pass
	
#implement Strategy Pattern for overriding Behaviour or Control Stacks
func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	#Handle pushing
	move_and_slide()
	Globals.player_position = global_position
	last_mouse_position = mouse_position()#rotate
	look_at(last_mouse_position)
	
	#position += direction * speed * delta

	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		print(Globals.laser_amount)
		$LaserParticle.emitting = true
		var laser_markers:Array = $LaserSpawnPosition.get_children()
		var selected_laser:Node2D = laser_markers.pick_random()
		can_laser = false
		$LaserTimer.start()
		var player_direction:Vector2 = (get_global_mouse_position() - position).normalized()
		laser_shot.emit(selected_laser.global_position, player_direction)
		
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var grenade_marker = $GrenadeSpawnPosition.get_child(0)
		can_grenade = false
		$GrenadeTimer.start()
		var player_direction:Vector2 = (get_global_mouse_position() - position).normalized()
		grenade_thrown.emit(grenade_marker.global_position,player_direction)
		

func _apply_collision():
	if move_and_slide():
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				col.get_collider().apply_force(col.get_normal() * -push_force)

func mouse_position() -> Vector2:
	var _mouse_position: Vector2
	if(overwrite_mouse == false):
		_mouse_position = Vector2(get_global_mouse_position())
	else: 
		_mouse_position = last_mouse_position
	
	return _mouse_position
	
func hit(sender):
	var _health:int = Globals.health_amount
	_health -= 10
	if(_health <= 0):
		queue_free()
		player_died.emit()
		
	Globals.health_amount = _health

func _on_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true

func add_item(type: String) -> void:
	if  type == 'laser':
		Globals.laser_amount += 5
		#UserInterface.update_laser_text()
	elif type == 'grenade':
		Globals.grenade_amount += 2
		#UserInterface.update_grenade_text()
	elif  type == 'health':
		Globals.health_amount += 15
		#UserInterface.update_health_bar()
		

