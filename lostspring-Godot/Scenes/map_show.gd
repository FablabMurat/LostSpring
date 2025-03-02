extends Area2D
signal _entered_map(emitter,body)
signal _exited_map(emitter,body)
func _on_body_entered(body: Node2D) -> void:
	_entered_map.emit(self, body)


func _on_body_exited(body: Node2D) -> void:
	_exited_map.emit(self, body)
