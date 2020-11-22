tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("GrassAd","Node2D",load("res://addons/GrassAd/Plugin.gd"),null)
	pass


func _exit_tree():
	remove_custom_type("GrassAd")
	pass
