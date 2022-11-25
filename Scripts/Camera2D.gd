extends Camera2D

onready var player := $"../Player"


func _process(delta: float) -> void:
	position = player.global_position
	var pos_x = floor(position.x / 512) * 512
	var pos_y = floor(position.y / 300) * 300
	global_position = Vector2(pos_x, pos_y)
