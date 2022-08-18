extends CanvasLayer


onready var shortcuts_path = "Skill_Bar/Background/"

var loaded_skills = {"Shortcut1": "Fireball", "Shortcut2": "Ice_Spear", "Shortcut3": "Lava_Bomb"}

func _ready():
	LoadShortcuts()
	for shortcut in get_tree().get_nodes_in_group("Shortcuts"):
		shortcut.connect("pressed", self, "SelectShortcut", [shortcut.get_parent().get_name()])

func LoadShortcuts():
	for shortcut in loaded_skills.keys():
		var skill_icon = load("res://Assets/Skills/" + loaded_skills[shortcut] + "_icon.png")
		get_node(shortcuts_path + shortcut + "/TextureButton").set_normal_texture(skill_icon)

func SelectShortcut(shortcut):
	var skill_icon = load("res://Assets/Skills/" + loaded_skills[shortcut] + "_icon.png")
	get_node(shortcuts_path + "/Selected_Skill/TextureRect").set_texture(skill_icon)
	get_parent().get_node("Test/Player/Player").selected_skill = loaded_skills[shortcut]
