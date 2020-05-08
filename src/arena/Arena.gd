extends Node2D

var enemy = preload("res://src/enemy/Enemy.tscn")

func _ready():
	Global.node_creation_parent = self

func _exit_tree():
	Global.node_creation_parent = null
	
func _on_Enemy_spawn_timer_timeout():
	var enemy_position = Vector2(rand_range(-60, 700), rand_range(-60, 420))
	
	while enemy_position.x > -50 and enemy_position.x < 690 and enemy_position.y > -50 and enemy_position.y < 410:
		enemy_position = Vector2(rand_range(-60, 700), rand_range(-60, 420))
	Global.instance_node(enemy, enemy_position, self)
