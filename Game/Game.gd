extends Node2D

var accumulative_scroll = 0
var segment_grow = 6

var tween_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):

	if event.is_action_pressed("esc"):
		get_tree().quit()
		
	if event.is_action_pressed("scroll_up") and !tween_playing:
		scroll_ruler($Ruler.get_children(), true)
			
	if event.is_action_pressed("scroll_down") and !tween_playing:
		scroll_ruler($Ruler.get_children(), false)

func scroll_ruler(segments, forward):

	var final_position

	#Move each segment in the ruler
	for segment in segments:
		if forward:
#			segment.position.x += segment_grow
			final_position = segment.position
			final_position.x += segment_grow
		else:
#			segment.position.x -= segment_grow
			final_position = segment.position
			final_position.x -= segment_grow
			
		var tween = create_tween().set_trans(Tween.TRANS_BACK)
		tween.tween_property(segment, "position", final_position, 0.3)
		tween_playing = true
		tween.connect("finished", tween_finished)

	if forward:
		accumulative_scroll += segment_grow
	else:
		accumulative_scroll -= segment_grow

	print(accumulative_scroll)
	#Create if going backwards
	if accumulative_scroll % 6 == 0 and forward:
		generate_ruler_segment()
		
	#Delete if going backwards
#	if accumulative_scroll > 0 and accumulative_scroll % 6 == 0 and !forward and !tween_playing:
#		delete_ruler_segment()

func tween_finished():
	for segment in $Ruler.get_children():
		if segment.position.x < -6:
			segment.queue_free()
			
	tween_playing = false
	

func generate_ruler_segment():
	var segment = Sprite2D.new()
	segment.texture = load("res://Game/Ruler/ruler_segment.png")
	segment.offset = Vector2(3,3)
	$Ruler.add_child(segment)
	
func delete_ruler_segment():
	$Ruler.get_children().back().queue_free()
	
