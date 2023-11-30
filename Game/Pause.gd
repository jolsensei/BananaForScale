extends CanvasLayer

func _on_accept_pressed():
	get_tree().paused = !get_tree().paused
	self.visible = false
	Transition.change_scene("res://Title/Title.tscn", true)


func _on_cancel_pressed():
	get_tree().paused = !get_tree().paused
	self.visible = false
