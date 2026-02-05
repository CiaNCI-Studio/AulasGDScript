class_name Main extends Node2D

var tamanhoDoAbacate : int = 6
var pesoDoAbacate : float = 0.750
var nomeDoAbacate : String = "filomena"
var oAbacateEstaMaduro : bool = true


func _ready() -> void:
	var soma = SomarAbacate(10, SomarAbacate(1, 1))
	print_debug(soma)

func SomarAbacate(valor1 : int, valor2 : int) -> int:
	print_debug("parametros: " + str(valor1) + " - " + str(valor2))
	var soma = (valor1 + valor2) * tamanhoDoAbacate
	return soma
	
