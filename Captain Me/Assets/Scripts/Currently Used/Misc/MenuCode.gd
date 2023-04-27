extends Control

func StartGame():
	get_tree().change_scene("res://Assets/Scene/Level1.tscn")

func QuitGame():
	get_tree().quit();
