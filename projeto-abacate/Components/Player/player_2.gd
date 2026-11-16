extends CharacterBody2D

var speed: float = 300.0 # 300 pixels por segundo

# Roda a cada frame desenhado na tela (FPS variável: 60, 120, 144...)
func _process(delta: float) -> void:
	
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	position += direction * speed * delta

# Roda em intervalo fixo (Padrão: 60 vezes por segundo)
func _physics_process(delta: float) -> void:
	velocity += (get_gravity() * delta)
	move_and_slide()
