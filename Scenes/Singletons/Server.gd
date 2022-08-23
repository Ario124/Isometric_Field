extends Node
var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
#var ip = "145.131.21.160"
var port = 1909

func _ready():
	ConnectToServer()

func ConnectToServer():
 network.create_client(ip, port)
 get_tree().set_network_peer(network)
 network.connect("connection_failed" , self, "_OnConnectionFailed")
 network.connect("connection_succeeded" , self, "_OnConnectionSucceeded")

func _OnConnectionFailed():
	print("Failed to connect")

func _OnConnectionSucceeded():
	print("Succesfully connected")

func FetchSkillDamage(skill_name, requester):
	rpc_id(1, "FetchSkillDamage", skill_name, requester)
	
remote func ReturnSkillDamage(s_damage, requester):
	instance_from_id(requester).SetDamage(s_damage)
