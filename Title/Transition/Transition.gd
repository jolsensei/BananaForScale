extends CanvasLayer

var scene_to_load

func change_scene(target_scene):
	scene_to_load = target_scene
	$AnimationPlayer.play("transition")
#	await $AnimationPlayer.animation_finished
#	get_tree().change_scene_to_file(target_scene)
#	$AnimationPlayer.play("transition_out")
	
func load_scene():
	get_tree().change_scene_to_file(scene_to_load)
