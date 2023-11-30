extends CanvasLayer

var next_level_ready = false
var current_level

var random_info = [
	"''Bananas used to have seeds''",
	"''Banana-flavored candy tastes like an extinct form of banana''",
	"''You need nuclear science to extract juice from bananas''",
	"''A banana can be a weapon''",
	"''Eating a banana can cheer you up''",
	"''Bananas are naturally radioactive''"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func success(next_level):
	#-2 beause we already steped up the level
	current_level = next_level
	$RandomText.text = random_info[next_level-2]
	
	$BG/Level.text = "Level " + str(next_level)
	$AnimationPlayer.play("success")
	$Drum.play()
	
func error():
	$AnimationPlayer.play("error")
	$Drum.play()


func animation_finished(anim_name):
	match anim_name:
		"success":
			if GameManager.check_next_level(current_level):
				$AnimationPlayer.play("level_change")
			else:
				Transition.change_scene("res://Game/Win/Win.tscn", false)
		"error":
			Transition.change_scene("res://Title/Title.tscn", true)
		"level_change":
			next_level_ready = true
		"level_change_out":
			SignalManager.change_level()

func click_to_next_level():
	if next_level_ready:
		next_level_ready = false
		$AnimationPlayer.play("level_change_out")


func drum_finished():
	if $AnimationPlayer.current_animation == "error":
		$ErrorSFX.play()
	if $AnimationPlayer.current_animation == "success":
		$SuccessSFX.play()
