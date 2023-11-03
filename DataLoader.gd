extends HTTPRequest

@export var label:Label
@export var sheetRange:String

func _ready():
	label.text = "Loading..."
	request_completed.connect(_on_request_completed)
	request("https://sheets.googleapis.com/v4/spreadsheets/1zVFZ3xQmuQNqU3PiH4WDdKjz_7GTsuOBJtiaPRGo2zA/values/Data!" + sheetRange + "?key=AIzaSyCRpqNvSeDkNpIAFqPd6KSLCBpwYv6m_QM")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	label.text = body.get_string_from_utf8()
