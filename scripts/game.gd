extends Node2D
@onready var player = $Player
@onready var portal = $Portal

func _ready():
	portal.playerTP.connect(go_TP)
func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position

func go_TP():
	player.position.x = portal.player_position_x
	player.position.y = portal.player_position_y
