extends AnimatedSprite2D

@onready var frog: CharacterBody2D = $".."
@onready var sprite_animado: AnimatedSprite2D = $"."

#region animaciones
func animaciones(delta):
	if (frog.velocity.x != 0):
		sprite_animado.play("correr")
	else:
		sprite_animado.play("parado")

	if(not frog.is_on_floor()):
		if(frog.velocity.y > 0):
			sprite_animado.play("caida")
		elif(frog.velocity.y < 0):
			sprite_animado.play("salto")
		frog.velocity.y += frog.gravedad * delta
		
	

#endregion

func _process(delta: float) -> void:
	animaciones(delta)
