extends Node2D

var buttons_visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("logo")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _unhandled_input(event):

	if event.is_action_pressed("esc"):
		get_tree().quit()
	
	if event.is_action_pressed("click") and !buttons_visible:
		$AnimationPlayer.play("show_buttons")
		# BACK, CUBIC, SPRING are cool options
		var tween = create_tween().set_trans(Tween.TRANS_BACK)
		var new_position = $Logo.position
		new_position.y = 36
		#Duration has to be the same as "show_buttons" duration
		tween.tween_property($Logo, "position", new_position, 1)
		tween.connect("finished", tween_finished)
		buttons_visible = true

func tween_finished():
	$AnimationPlayer.play("logo_with_buttons")
