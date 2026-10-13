class_name AvePequenaAnim extends Node2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprites: Node2D = $Sprites
@onready var atack_point: Marker2D = $Sprites/AtackPoint

var parent : CharacterBody2D

func _ready() -> void:
	parent = get_parent()	

func _process(delta: float) -> void:
	if parent:
		var speed = parent.velocity.x
		if parent.is_on_floor():
			var animationSpeed = remap(abs(speed),0.0, 600.0, 0.0, 1.0)
			animation_tree.set("parameters/Speed/blend_position", animationSpeed)
		else:
			animation_tree.set("parameters/Speed/blend_position", 0)
		if speed < 0:
			sprites.scale.x = abs(sprites.scale.x)
		elif speed > 0:
			sprites.scale.x = -abs(sprites.scale.x)

func GetAtackPoint() -> Marker2D:
	return atack_point

func Atack():
	animation_tree.set("parameters/Atack/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
