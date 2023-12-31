extends CanvasLayer


func change_scene(target: String) -> void:
	UserInterface.visible = false
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target) 
	$AnimationPlayer.play("reveal")
	UserInterface.visible = true
