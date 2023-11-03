extends HTTPRequest

@export var sheetId:String
@export var tab:String
@export var key:String
@export var sheetRange:String
@export var label:Label
@export var textureRect:TextureRect

func _ready():
	label.text = "Loading..."
	request_completed.connect(_on_request_completed)
	request("https://sheets.googleapis.com/v4/spreadsheets/"+sheetId+"/values/"+tab+"!"+sheetRange+"?key="+key)

func _on_request_completed(_result, _response_code, headers, body):
	var contentType = ""
	for header in headers:
		if("Content-Type:" in header):
			contentType = header
	if("json" in contentType):
		parse_json(body.get_string_from_utf8())
	else:
		parse_image(body)

func parse_json(bodyString:String):
	label.text = bodyString
	var json = JSON.parse_string(bodyString)
	var imageURL = str(json["values"][1][2])
	print(imageURL)
	request(imageURL)

func parse_image(body):
	var image = Image.new()
	#image.load_png_from_buffer(body)
	#var texture = ImageTexture.new()
	#texture.create_from_image(image)
	#textureRect.texture = texture;
