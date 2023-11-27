extends StaticContainer

func hit(sender):
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos,current_direction)
		opened = true
