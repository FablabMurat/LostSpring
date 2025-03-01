extends Area2D

signal _entered(monsterName,body)
signal _exited(monsterName,body)
	
func _on_body_entered(body: Node2D) -> void:
	_entered.emit(self,body)
	
func _on_body_exited(body: Node2D) -> void:
	_exited.emit(self,body)
