extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var ave_pequena_anim: AvePequenaAnim = $AvePequenaAnim

@export var Active : bool = true
@export var Static : bool = false
@export var AtackDistance : float = 1000
@export var Speed : float = 100.0
@export var Hp : int = 2

var movingValue : float
var movingTimer : float

func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if not Active:
		return
	
	if movingTimer > 0:
		movingTimer -= delta
		velocity.x = lerp(velocity.x, movingValue, 0.2)
	elif velocity.x != 0:
		movingValue = 0
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		
	move_and_slide()

func Damage():
	Hp -= 1
	var instance =load("res://Components/Effects/AveImpact.tscn").instantiate()
	instance.global_position = global_position
	get_parent().add_child(instance)
	if Hp <= 0:
		queue_free()
		
func Atack():	
	var fireMarker = ave_pequena_anim.GetAtackPoint()
	var player = get_tree().get_first_node_in_group("player") as Player
	if fireMarker and player:		
		var rock = load("res://Components/Projectiles/Rock.tscn").instantiate() as Rock
		rock.global_position = fireMarker.global_position
		rock.global_rotation = fireMarker.global_rotation		
		rock.Direction = fireMarker.global_position.direction_to(player.global_position)
		get_parent().add_child(rock)
		ave_pequena_anim.Atack()
	
func Move():	
	if not Active or Static:
		return
	movingValue = randi_range(-1, 1) * Speed
	movingTimer = randf_range(3, 5)
	
func CheckPlayer() -> bool:
	var result = false
	var player = get_tree().get_first_node_in_group("player")
	if player:
		if global_position.distance_to(player.global_position) <= AtackDistance:
			result = true
	return result


func _on_impact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		body.queue_free()
		Damage()
		
