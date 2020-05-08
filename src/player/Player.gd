extends Sprite

var bullet = preload("res://src/player/Bullet.tscn")
var speed = 150
var velocity = Vector2()
var can_shoot = true

func _ready():
	Global.player = self
func _exit_tree():
	Global.player = null

func _process(delta):
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized()
	
	global_position += velocity * speed * delta
	
	if Input.is_action_pressed("click") and can_shoot:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start()
		can_shoot = false

func _on_Reload_speed_timeout():
	can_shoot = true

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player_damager"):
		modulate = Color.red
		$Stun_timer.start()

func _on_Stun_timer_timeout():
	modulate = Color.white
