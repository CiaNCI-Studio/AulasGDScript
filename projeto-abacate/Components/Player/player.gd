class_name Player extends CharacterBody2D

@onready var player_anim: PlayerAnim = $PlayerAnim
@onready var side_scrolling_controler_2d: SideScrollingControler2D = $SideScrollingControler2D
@export var FireCadence : float = 0.5

var cadenceTimer : float = 0
var fireMarker: Marker2D
var Hp : int = 10

func _ready() -> void:
	get_tree().current_scene.ready.connect(func(): GlobalSignals.OnHpUpdate.emit(Hp), CONNECT_ONE_SHOT)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action") and side_scrolling_controler_2d.Active:
		Atack()	
	if Input.is_action_just_released("action"):
		ReleaseAtack()	
	if cadenceTimer > 0:
		cadenceTimer -= delta

func _on_side_scrolling_controler_2d_jump_start() -> void:
	player_anim.Jump()

func Damage():
	Hp -= 1
	GlobalSignals.OnHpUpdate.emit(Hp)
	var instance =load("res://Components/Effects/PlayerImpact.tscn").instantiate()
	instance.global_position = global_position
	get_parent().add_child(instance)
	if Hp <= 0:
		await get_tree().create_timer(2).timeout
		get_tree().quit()

func Atack():	
	ChangeAtackPosition()	
	if fireMarker and cadenceTimer <= 0:		
		cadenceTimer = FireCadence			
		var bullet = load("res://Components/Projectiles/Bullet.tscn").instantiate() as Bullet
		bullet.global_position = fireMarker.global_position
		bullet.global_rotation = fireMarker.global_rotation
		bullet.Direction = bullet.global_transform.basis_xform(Vector2.RIGHT)
		get_parent().add_child(bullet)

	
func ChangeAtackPosition():
	if Input.is_action_pressed("action") and side_scrolling_controler_2d.Active:
		if Input.is_action_pressed("up") and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
			fireMarker = player_anim.SetFirePosition(PlayerAnim.FirePositions.Diagonal)
		elif Input.is_action_pressed("up"):
			fireMarker = player_anim.SetFirePosition(PlayerAnim.FirePositions.Up)
		else:
			fireMarker = player_anim.SetFirePosition(PlayerAnim.FirePositions.Front)

func ReleaseAtack():
	fireMarker = player_anim.SetFirePosition(PlayerAnim.FirePositions.None)
	
func _on_impact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("atack"):
		body.queue_free()
		Damage()
