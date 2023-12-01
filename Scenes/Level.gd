extends Node2D
class_name LevelParent

var laser_scene = preload("res://Scenes/laser.tscn")
var grenade_scene = preload("res://Scenes/grenade.tscn")
var item_scene = preload("res://Scenes/item.tscn")
var startingPos : float 
var test_array: Array[String] =  ["Test","Hello","Stuff"]
@onready var starting_zoom = $Player/Player_Camera.zoom
@export var indoor_zoom: Vector2 = Vector2(0.8,0.8)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("player_died", _game_over_scene_transition)
	for _container in get_tree().get_nodes_in_group('Container'):
		_container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser", _on_scout_laser)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func  _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	item.is_open = false
	#item.open_container_tween()
	$Items.call_deferred('add_child',item)

func _on_player_laser_shot(pos,direction):
	create_laser(pos,direction)
	

func _on_player_grenade_thrown(pos,direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade,true)
	UserInterface.update_grenade_text()
	
func _on_scout_laser(pos,direction):
	create_laser(pos,direction)
	
func create_laser(pos,direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.direction = direction
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	$Projectiles.add_child(laser,true)
	UserInterface.update_laser_text()
		
func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Player_Camera,"zoom",indoor_zoom,1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Player_Camera, "zoom", starting_zoom,2)


func _on_gate_on_player_entered(body):
	var tween = create_tween()
	tween.tween_property($Player,"speed",0,0.5)
	TransitionLayer.change_scene("res://Scenes/inside.tscn")
	$Player.overwrite_mouse = true

func _game_over_scene_transition():
	TransitionLayer.change_scene("res://Scenes/game_over.tscn")
