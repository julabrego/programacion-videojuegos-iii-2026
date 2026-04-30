extends AnimatableBody2D

var direction: Vector2 = Vector2.ZERO
var speed = 400

func _physics_process(delta: float) -> void:
	var target_position = position + direction.normalized() * speed * delta
	var motion = target_position - position
	var collision = move_and_collide(motion, true)
	
	if collision:
		var collider = collision.get_collider()
		if collider != null:
			apply_damage_if_corresponds(collider)
			if destroy_if_corresponds(collider):
				queue_free()
				
	position = target_position

func destroy_if_corresponds(collider: Object):
	return collider.is_in_group("hits_bullet")

func apply_damage_if_corresponds(collider: Object):
	if(collider.has_method("get_damage")):
		collider.get_damage()
