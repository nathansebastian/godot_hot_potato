extends Node

signal stat_change

var player_position: Vector2
var  laser_amount = 20:
	set(value):
		laser_amount = value
		laser_amount = limit_value(laser_amount,20)
		stat_change.emit()
var  grenade_amount = 5:
	set(value):
		grenade_amount = value
		grenade_amount = limit_value(grenade_amount,5)
		stat_change.emit()
var  health_amount = 80:
	set(value):
		health_amount = value
		health_amount = limit_value(health_amount,100)
		stat_change.emit()

	
func limit_value(arg1:int, _max:int) -> int:
	if(arg1 > _max):
		arg1 = _max
	return arg1

