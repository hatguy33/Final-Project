extends Node2D
@onready var player = $Player
@onready var portal = $Portal


func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position

