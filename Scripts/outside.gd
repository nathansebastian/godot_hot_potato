extends LevelParent


func _on_gate_on_player_entered(body):
	var tween = create_tween()
	tween.tween_property($Player,"speed",0,0.5)
	tween.tween_property($Player,"speed",$Player.max_speed,1).set_delay(.5)


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Player_Camera,"zoom",indoor_zoom,1)
	
	
func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Player_Camera,"zoom",starting_zoom,2)
