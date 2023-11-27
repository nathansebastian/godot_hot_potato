extends Node

@export var body_entered_function:String = ""

var body_entered_callable: Callable

func _ready():
	if body_entered_function:
		body_entered_callable = Callable(get_parent(),body_entered_function)

func on_body_entered(sender):
	
	print("damage from " + sender.name)
	
	if body_entered_function:
		body_entered_callable.call(sender)
