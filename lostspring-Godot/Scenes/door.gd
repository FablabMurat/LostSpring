extends StaticBody2D

signal _entered(doorName,body)
func _ready():
	var colorName = self.name.substr(4,-1) 
	$doorSprite.modulate = Color(colorName)
	print("door holder color" + colorName)
	
func _on_body_entered(body: Node2D) -> void:
	_entered.emit(self,body)
