extends CharacterBody2D

@onready var jugador = $AnimatedSprite2D

"""ZONA DE EXPORTS"""

@export_category("Configuracion")
@export var speed: float
@export var vel_salto: float = 400.0
var gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")
var mirando_derecha: bool = true

func _ready() -> void:
	jugador.play("parado")
	
#region sistema de salto y gravedad
func dobleSalto() ->void:
	pass

func salto(delta):
	
	if (Input.is_action_pressed("w") and is_on_floor()):
		velocity.y = -vel_salto
		
	if(not is_on_floor()):
		jugador.play("salto")
		velocity.y += gravedad * delta
	
#endregion

#region animaciones
func animaciones():
	if (velocity.x != 0):
		jugador.play("correr")
	else:
		jugador.play("parado")
#endregion

#region Movimientos
func movimiento() -> void:
	var movimiento_h = Input.get_axis("a","d") #Movimiento Horizontal
	velocity.x = speed * movimiento_h
		
	#si mira a la derecha y esta corriendo hacia la izquierda Girar al personaje
	if(mirando_derecha and movimiento_h < 0) or (not mirando_derecha and movimiento_h > 0):
		scale.x *= -1 #Gira al Jugador
		mirando_derecha = not mirando_derecha
	
	move_and_slide()
#endregion
		
func _physics_process(delta: float) -> void:	
	movimiento()
	animaciones()
	salto(delta)
