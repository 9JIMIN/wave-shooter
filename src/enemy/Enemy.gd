extends Sprite

var speed = 100
var velocity = Vector2()
var stun = false
var hp = 3

var blood_particles = preload("res://src/enemy/Blood.tscn")

func _process(delta):
	if stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	
	global_position += velocity * speed * delta
	
	if hp <= 0:
		Global.points += 10
		var blood_particles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
		blood_particles_instance.rotation = velocity.angle()
		queue_free()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		modulate = Color.red
		velocity = -velocity * 3
		stun = true
		hp -= 1
		$Stun_timer.start()
		area.get_parent().queue_free()

func _on_Stun_timer_timeout():
	modulate = Color("f76f0c")
	stun = false
	
