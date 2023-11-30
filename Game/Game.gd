extends Node2D

var accumulative_scroll = 0
var segment_grow = 6

var tween_playing = false
var last_direction_forward = false

#Gameplay vars
var current_level = 1
var current_treshold
var current_increment
var item_A
var size_A = 17
var item_B
var size_B = 0

var player_response = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("item")
	current_treshold = float(GameManager.get_threshold(str(current_level)))
	current_increment = float(GameManager.get_increment(str(current_level)))
	next_level(current_level)
	SignalManager.connect("change_level_signal", prepare_next_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(event):
	
	if event.is_action("scroll_up") and !tween_playing and accumulative_scroll < 156:
		scroll_ruler(true)
		$ClickRuler.play()
			
	if event.is_action("scroll_down") and accumulative_scroll > 0 and !tween_playing:
		scroll_ruler(false)
		$ClickRuler.play()

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
		player_response += current_increment
	else:
		accumulative_scroll -= segment_grow
		player_response -= current_increment
	
	print(player_response)
	
	$Number.bbcode_text = "%05.1f" % [absf(player_response)]

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

func reset_ruler():
	accumulative_scroll = 0
	player_response = 0
	$Number.bbcode_text = "%05.1f" % [player_response]
	$Meter/Ruler.position = Vector2(6, 0)
	var segments = $Meter/Ruler.get_child_count()
	for child in $Meter/Ruler.get_children():
		if segments > 2:
			$Meter/Ruler.get_child(segments-1).queue_free()
			segments -= 1

func prepare_next_level():
	next_level(current_level)

func next_level(level):
	
	level = str(level)
	
	if level == "1":
		item_B = GameManager.get_item(level)
		size_B = GameManager.get_size(level, item_B)
		$NameB.bbcode_text = "[center][wave freq=2]%s[/wave][/center]" % [item_B]
		var texture = "res://Game/Items/Images/%s.png" % [GameManager.get_png_name(level, item_B)]
		$ItemB.texture = ResourceLoader.load(texture)
	else:
		reset_ruler()
		
		#Swap mode only
#		item_A = item_B
#		size_A = size_B
#		$NameA.bbcode_text = "[center][wave]%s[/wave][/center]" % [item_B]
#		$ItemA.texture = $ItemB.texture
		
		current_treshold = float(GameManager.get_threshold(level))
		current_increment = float(GameManager.get_increment(level))
		
		item_B = GameManager.get_item(level)
		size_B = GameManager.get_size(level, item_B)
		$NameB.bbcode_text = "[center][wave freq=2]%s[/wave][/center]" % [item_B]
		var texture_B = "res://Game/Items/Images/%s.png" % [GameManager.get_png_name(level, item_B)]
		$ItemB.texture = ResourceLoader.load(texture_B)

func _on_back_pressed():
	$Pause.visible = true
	get_tree().paused = !get_tree().paused


func _on_done_pressed():
	var calculation = float(size_A) * player_response
	var inf_threshold = float(size_B) - current_treshold
	var sup_threshold = float(size_B) + current_treshold
	print(calculation)
	print(inf_threshold)
	print(sup_threshold)
	if calculation > inf_threshold-1 and calculation < sup_threshold+1:
		current_level += 1
		$LevelResult.success(current_level)
	else:
		$LevelResult.error()


func on_hover():
	$ClickButton.play()
