extends CanvasLayer

@onready var main: Control = $Main
@onready var settings: Control = $Settings




func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")




func _on_options_pressed():
	main.visable = false
	settings.visbale = true
	
	


func _on_quit_pressed():
	get_tree().quit()



func _on_back_pressed():
	main.visable = true
	settings.visbale = false


#audio
var master_bus = AudioServer.get_bus_index("Master")
func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
