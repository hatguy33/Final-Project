extends Area2D

signal playerTP(portal_name)

@export var player_position_x : int
@export var player_position_y : int


func _on_body_entered(body):
	#playerTP.emit([self.name])
	playerTP.emit()
