extends CanvasLayer

var green:Color = Color("6bbfa3")
var red:Color = Color(1, 0, 0.2)
var max_laser_amount: int = 20
var max_grenade_amount: int = 5
var max_health_amount: int = 50
@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var health_progress_bar: Range = $MarginContainer/TextureProgressBar
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

func _ready():
	Globals.connect("stat_change",update_stats)
	update_laser_text()
	update_grenade_text()
	update_health_bar()
	
func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	modulate_control(laser_label,laser_icon,green)
	update_color()
	
func update_grenade_text():	
	grenade_label.text = str(Globals.grenade_amount)
	modulate_control(grenade_label,grenade_icon,green)
	update_color()
	
func update_health_bar():
	health_progress_bar.value = Globals.health_amount
	
func update_stats():
	update_laser_text()
	update_grenade_text()
	update_health_bar()
	
func update_color():
	if(Globals.laser_amount <= 0):
		modulate_control(laser_label,laser_icon, red)
	if(Globals.grenade_amount <= 0):
		modulate_control(grenade_icon,grenade_label,red)
		
func modulate_control(arg1:Control, arg2:Control, arg3:Color) -> void:
	arg1.modulate = arg3
	arg2.modulate = arg3
	
