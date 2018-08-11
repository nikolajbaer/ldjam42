extends Area

const BULLET_SPEED = 50
const BULLET_DAMAGE = 1
const KILL_TIMER = 4
var hit_something = false
var timer = 0
	
func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * BULLET_SPEED * delta)
	
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()
	
func _on_EnergyBall_body_entered(body):
	if hit_something == false:
		if body.has_method("bullet_hit"):
			body.bullet_hit(BULLET_DAMAGE, self.global_transform.origin)
			
	hit_something = true
	queue_free()

