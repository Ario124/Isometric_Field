extends CanvasLayer

#onready var shortcuts_path = "SkillBar/Background/HBoxContainer/"
#
#var loaded_skills = {"Shortcut1": "Fireball", "Shortcut2": "Ice_Spear"}
#
#func _ready():
#	LoadShortcuts()
#	for shortcut in get_tree().get_nodes_in_group("Shortcuts"):
#		shortcut.connect("pressed", self, "SelectedShortcut", [shortcut.get_parent().get_name()])
#
#func LoadShortcuts():
#	for shortcut in loaded_skills.keys():
#		var skill_icon = load("res://Assets/Skills/" + loaded_skills[shortcut] + "_icon.png")
#		get_node(shortcuts_path + shortcut + "/TextureButton").set_normal_texture(skill_icon)
#
#func SelectorShortcut(shortcut):
#	pass
