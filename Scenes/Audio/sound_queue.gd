@tool
extends Node


var _next:int = 0
var _audio_stream_players : Array[AudioStreamPlayer]
@export var count:int = 1

func _ready():
	var child = get_child(0)
	
	if(get_child_count() == 0):
		print("No AudioStreamPlayer child found")
		return
	
	if(child.get_class() == "AudioStreamPlayer"):
		_audio_stream_players.append(child)
		for i in count:
			var _duplicate :AudioStreamPlayer = child.duplicate() as AudioStreamPlayer
			add_child(_duplicate)
			_audio_stream_players.append(_duplicate)

func _get_configuration_warnings():
	if(get_child_count() == 0):
		return ["No Children found. Expected one AudioStreamPlayer child"]
	if(get_child(0).get_class() != "AudioStreamPlayer"):
		return ["Expected first child to be an AudioStreamPlayer"]
	return []
	
func play_sound() -> void:
	if(!_audio_stream_players[_next].playing):
		_next += 1
		_audio_stream_players[_next].play()
		_next %= _audio_stream_players.size() - 1
		
		
