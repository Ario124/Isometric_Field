extends Node


var mapstart = preload("res://Scenes/Test_Field.tscn")

func _ready():
	var mapstart_instance = mapstart.instance()
	add_child(mapstart_instance)
