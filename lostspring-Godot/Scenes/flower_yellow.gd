extends Area2D

signal _entered(name: String)
	
var flowerColor
	

func _ready():
	flowerColor = self.name.substr(6,-1)
	
	$flowerSprite.modulate = Color(flowerColor)

func _getName():
	return self.name


func _on_flower_yellow_body_entered(body: Node2D, extra_arg_0: StringName) -> void:
	_entered.emit(flowerColor)
