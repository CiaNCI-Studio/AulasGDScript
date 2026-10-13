class_name PlayerAnim extends Node2D

enum FirePositions{
	None,
	Front,
	Diagonal,
	Up	
}

@onready var sprite: Node2D = $Sprite
@onready var front_spawn_point: Marker2D = $Sprite/FrontSpawnPoint
@onready var diagonal_spawn_point: Marker2D = $Sprite/DiagonalSpawnPoint
@onready var up_spawn_point: Marker2D = $Sprite/UpSpawnPoint
@onready var dust_spawn_point: Marker2D = $Sprite/DustSpawnPoint
@onready var animation_tree: AnimationTree = $AnimationTree
var parent : CharacterBody2D

func _ready() -> void:
	parent = get_parent()

func _process(delta: float) -> void:
	if parent:
		var speed = parent.velocity.x
		if parent.is_on_floor():
			var animationSpeed = remap(abs(speed),0.0, 600.0, 0.0, 1.0)
			animation_tree.set("parameters/Speed/blend_position", animationSpeed)
			animation_tree.set("parameters/Falling/blend_amount", 0.0)
		else:
			animation_tree.set("parameters/Speed/blend_position", 0)
			animation_tree.set("parameters/Falling/blend_amount", 1.0)
		if speed > 0:
			sprite.scale.x = abs(sprite.scale.x)
		elif speed < 0:
			sprite.scale.x = -abs(sprite.scale.x)
			
func Jump():
	animation_tree.set("parameters/Jump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func SetFirePosition(position : FirePositions) -> Marker2D:	
	match position:
		FirePositions.None:
			animation_tree.set("parameters/FireFront/blend_amount", 0.0)
			animation_tree.set("parameters/FireDiagonal/blend_amount", 0.0)
			animation_tree.set("parameters/FireUp/blend_amount", 0.0)			
		FirePositions.Front:
			animation_tree.set("parameters/FireFront/blend_amount", 1.0)
			animation_tree.set("parameters/FireDiagonal/blend_amount", 0.0)
			animation_tree.set("parameters/FireUp/blend_amount", 0.0)
			return front_spawn_point
		FirePositions.Diagonal:
			animation_tree.set("parameters/FireFront/blend_amount", 0.0)
			animation_tree.set("parameters/FireDiagonal/blend_amount", 1.0)
			animation_tree.set("parameters/FireUp/blend_amount", 0.0)
			return diagonal_spawn_point
		FirePositions.Up:
			animation_tree.set("parameters/FireFront/blend_amount", 0.0)
			animation_tree.set("parameters/FireDiagonal/blend_amount", 0.0)
			animation_tree.set("parameters/FireUp/blend_amount", 1.0)
			return up_spawn_point
	return null

		
