extends Area2D

@export var player_position_x : int
@export var player_position_y : int


func _on_body_entered(body):
	WorldSignals.tp_point.emit(player_position_x, player_position_y)
