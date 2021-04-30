extends Control


func _ready():
	OS.center_window()


# For the server
func host_game(port):
	var host = NetworkedMultiplayerENet.new()
	host.create_server(port)
	get_tree().set_network_peer(host)


# For the clients
func join_game(ip, port):
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, port)
	get_tree().set_network_peer(host)


func _update_text(txt):
	$Label.text = $Label.text + '\n' + txt


sync func _sync_update_text(txt):
	_update_text('sync ' + txt)

master func _master_update_text(txt):
	_update_text('master ' + txt)

slave func _slave_update_text(txt):
	_update_text('slave ' + txt)

remote func _remote_update_text(txt):
	_update_text('remove ' + txt)


func _on_Button_pressed():
	rpc('_sync_update_text', 'ping !')
	rpc('_master_update_text', 'ping !')
	rpc('_slave_update_text', 'ping !')
	rpc('_remote_update_text', 'ping !')
