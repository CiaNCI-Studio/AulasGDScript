extends Node2D

@export var Lifetime : float = 5.0
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	gpu_particles_2d.emitting = true	

func _process(delta: float) -> void:
	Lifetime -= delta
	if Lifetime <= 0:
		queue_free()
