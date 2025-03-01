extends Area2D

signal _entered(holderName,body)
func _ready():
	var colorName = self.name.substr(12,-1) 
	$flowerHolderSprite.modulate = Color(colorName)
	print(str($flowerHolderSprite.name) +  " color " + colorName)

func _on_body_entered(body: Node2D) -> void:
	_entered.emit(self,body)
