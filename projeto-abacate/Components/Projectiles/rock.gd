class_name Rock extends RigidBody2D

@export var Force : float = 500
@export var Lifetime : float = 25
@export var Direction : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	linear_velocity = Direction * Force
	Lifetime -= delta
	if Lifetime <= 0:
		queue_free()
