extends Node

var rng = RandomNumberGenerator.new()

var levels = {
	"1": {
		"increment" : 0.2,
		"threshold" : 5,
		"items" : {
			"Cucumber" : { "size" : "30", "png_name" : "cucumber" },
			"A4 Paper sheet" : { "size" : "30", "png_name" : "a4" },
			"Play Station 5" : { "size" : "39", "png_name" : "ps5" },
		}
	},
	"2": {
		"increment" : 0.3,
		"threshold" : 4,
		"items" : {
			"Baseball bat" : { "size" : "83", "png_name" : "baseball" },
			"Katana" : { "size" : "110", "png_name" : "katana" },
			"Broom" : { "size" : "120", "png_name" : "broom" },
		}
	},
	"3": {
		"increment" : 1.2,
		"threshold" : 30,
		"items" : {
			"Coffin" : { "size" : "213", "png_name" : "coffin" },
			"Surf table" : { "size" : "250", "png_name" : "surf" },
			"Pool table" : { "size" : "250", "png_name" : "pool" },
		}
	},
	"4": {
		"increment" : 2,
		"threshold" : 30,
		"items" : {
			"Car" : { "size" : "420", "png_name" : "car" },
			"Giraffe" : { "size" : "550", "png_name" : "giraffe" },
		}
	},
	"5": {
		"increment" : 30,
		"threshold" : 200,
		"items" : {
			"Eolic windmill" : { "size" : "7000", "png_name" : "eolic" },
			"Statue of Liberty" : { "size" : "9300", "png_name" : "statue" },
			"Soccer field" : { "size" : "10000", "png_name" : "field" },
		}
	},
	"6": {
		"increment" : 66,
		"threshold" : 500,
		"items" : {
			"Great Pyramid of Giza" : { "size" : "13900", "png_name" : "pyramid" },
			"Titanic" : { "size" : "26900", "png_name" : "titanic" },
		}
	}
}

func check_next_level(level):
	return levels.has(str(level))

func get_item(level):
	var size = levels[level].items.size()
	var random_item = levels[level].items.keys()[randi() % size]
	
	return random_item
	
func get_size(level, item):
	return levels[level].items[item]["size"]
	
func get_png_name(level, item):
	return levels[level].items[item]["png_name"]
	
func get_threshold(level):
	return levels[level]["threshold"]
	
func get_increment(level):
	return levels[level]["increment"]
