extends Area2D

var rotation_speed: int = 5
var available_options = ['laser','laser','laser','grenade','health'] 
var type = available_options[randi()%len(available_options)] 
var is_open:bool = true
@export var direction: Vector2
@onready var original_pos: Vector2 = position

var direction_angle: int = randi_range(0,360)
var distance:int = randi_range(150,250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1354284286499, 0.31766137480736, 0.77994179725647)
	if type =='grenade':
		$Sprite2D.modulate = Color(0.69019609689713, 0.03529411926866, 0.08627451211214)
	if type =='health':
		$Sprite2D.modulate = Color(0.05579998344183, 0.62000000476837, 0.14042991399765)
	
	if( not is_open):
		open_container_tween()
	
func _process(delta):
	#var target_pos = original_pos + direction * distance
	#var movement_tween = get_tree().create_tween()
	#movement_tween.tween_property(self,"position",target_pos,0.5)
	
	rotation += rotation_speed * delta
	
func open_container_tween():
	print("Open container tween")
	original_pos = position
	var target_pos = position + direction * distance
	var movement_tween = get_tree().create_tween()
	movement_tween.set_parallel(true)
	movement_tween.tween_property(self,"position",target_pos,0.5)
	movement_tween.tween_property(self,"scale",Vector2(1,1),0.3).from(Vector2(0,0))
func _on_body_entered(body):
	body.add_item(type)
	queue_free()	
