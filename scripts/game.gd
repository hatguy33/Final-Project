extends Node2D
@onready var player = $Player
@onready var portal = $Portal
var portals = {}
func _ready():
	for portal in get_tree().get_nodes_in_group("portals"):
		#portal.playerTP.connect(go_TP)
		#portal.playerTP.connect("go_TP", self)
		portals[portal.name] = portals
func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position

func go_TP():
	player.position.x = portal.player_position_x
	player.position.y = portal.player_position_y
