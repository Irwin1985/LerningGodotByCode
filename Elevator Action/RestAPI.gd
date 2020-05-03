extends Control


func _ready():
	OS.center_window()


func _on_Button_pressed():
	$HTTPRequest.request("https://jsonplaceholder.typicode.com/todos/1")
	print($HTTPRequest.get_http_client_status())


func _on_HTTPRequest_request_completed(result, response_code, headers, body:PoolByteArray):
	var json = JSON.parse(body.get_string_from_utf8())
	$TextEdit.text = to_json(json.result)
	var vec:Vector2
	vec.length()
