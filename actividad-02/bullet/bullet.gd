extends AnimatableBody2D

var direction: Vector2 = Vector2.ZERO
@export var speed = 400

func _physics_process(delta: float) -> void:
	var target_position = position + direction.normalized() * speed * delta
	var motion = target_position - position
	var collision = move_and_collide(motion, true)
	
	if collision:
		var collider = collision.get_collider()
		if collider != null:
			apply_damage_if_corresponds(collider)
			destroy_if_corresponds(collider)
				
	position = target_position

func apply_damage_if_corresponds(collider: Object):
	if(collider.has_method("get_damage")):
		collider.get_damage()

func destroy_if_corresponds(collider: Object):
	if collider.is_in_group("hits_bullet"):
		queue_free()
