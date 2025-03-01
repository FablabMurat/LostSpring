extends Area2D

signal _entered(monsterName,body)

	
func _on_body_entered(body: Node2D) -> void:
	_entered.emit(self,body)
