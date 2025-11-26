extends Node

var api_base_url := "https://game-server.gamerpal.com"

func _ready() -> void:
	if AuthManager.load_session():
		print("Startup: loaded session from disk. User:", AuthManager.username, "Guest:", AuthManager.is_guest)
	else:
		print("Startup: no saved session, will guest-login when needed.")
 
