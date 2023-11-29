extends RigidBody2D

@export var speed:int = 750
@export var body_entered_reciever = ""
@onready var intial_explosion: Area2D = $"HurtArea/Intial Explosion"
@onready var last_explosion: Area2D = $"HurtArea/Last Explosion"
var _explosion_area: Area2D
var exploding:bool = false
var _damagables:Array[Node2D] 

func explode():
	$AnimationPlayer.play("explosion")

func _ready():
	pass#intial_explosion.disconnect("body_entered",_on_intial_explosion_body_entered)

func _process(_delta):
	if(exploding):
		for damagable in _explosion_area.get_overlapping_bodies():
			if (damagable.is_in_group('Damagable')):
				_damagables.append(damagable)
		print("damagables ")
		print(_damagables)
		call_damagables()
		_damagables.clear()
		exploding = false


	
func enable_hurt_area_intial_explosion() -> void:
	_explosion_area = intial_explosion
	exploding = true
	
func enable_hurt_area_last_explosion() -> void:
	_explosion_area = last_explosion
	exploding = true

func call_damagables() -> void:
	for body in _damagables:
		if(body.has_node(body_entered_reciever)):
			var _body = body.get_node(body_entered_reciever)
			_body.on_body_entered(self)

func _on_intial_explosion_body_entered(body):
	print("body entered")
