extends Control

@onready var vidas: Label = $HBoxContainer/Vidas

func _ready() -> void:
	GlobalSignals.OnHpUpdate.connect(UpdateHp)
	
func UpdateHp(hp : int):
	vidas.text = str(hp)
