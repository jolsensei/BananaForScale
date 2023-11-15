extends Node2D

var accumulative_scroll = 0
var segment_grow = 6

var tween_playing = false
var last_direction_forward = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):

	if event.is_action_pressed("esc"):
		get_tree().quit()
		
	if event.is_action_pressed("scroll_up") and !tween_playing:
		scroll_ruler(true)
			
	if event.is_action_pressed("scroll_down") and accumulative_scroll > 0 and !tween_playing:
		scroll_ruler(false)

func scroll_ruler(forward):

	last_direction_forward = forward
	
	if accumulative_scroll % 6 == 0 and !forward:
		delete_ruler_segment()

	var final_position = Vector2(0,0)
	final_position = $Meter/Ruler.position
	
	if forward:
		final_position.x += segment_grow
	else:
		final_position.x -= segment_grow
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property($Meter/Ruler, "position", final_position, 0.1)
	tween_playing = true
	tween.connect("finished", tween_finished)

	if forward:
		accumulative_scroll += segment_grow
	else:
		accumulative_scroll -= segment_grow

	print(accumulative_scroll)


func tween_finished():
	if accumulative_scroll % 6 == 0 and last_direction_forward:
		generate_ruler_segment()
	
	tween_playing = false

func generate_ruler_segment():
	var segment = Sprite2D.new()
	segment.texture = load("res://Game/Ruler/ruler_segment.png")
	segment.offset = Vector2(3,3)
	#The whole ruler is moving, so we need to atach the new segment to the end of the ruler
	segment.position.x = accumulative_scroll * -1
	$Meter/Ruler.add_child(segment)
	
func delete_ruler_segment():
	$Meter/Ruler.get_children().back().queue_free()
	
