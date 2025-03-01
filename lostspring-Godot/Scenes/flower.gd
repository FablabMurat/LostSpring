extends Area2D

signal _entered(flowerName,body)
func _ready():
	var colorName = self.name.substr(6,-1) 
	$flowerSprite.modulate = Color(colorName)

func _on_body_entered(body: Node2D) -> void:
	_entered.emit(self,body)
