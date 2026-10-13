class_name Bullet extends RigidBody2D

@export var Force : float = 2000
@export var Lifetime : float = 10
@export var Direction : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	linear_velocity = Direction * Force
	Lifetime -= delta
	if Lifetime <= 0:
		queue_free()
