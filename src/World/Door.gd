extends Area2D

export(Resource) var connection = null
export(String, FILE, '*.tscn') var new_level_path = ""
var active = true


func _on_Door_body_entered(Player) -> void:
	if active == true:
		if "Wizard" in Player.name:
			print(Player.name)
			Player.emit_signal('hit_door', self)
			active = false
