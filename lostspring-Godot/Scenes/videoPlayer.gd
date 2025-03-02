extends VideoStreamPlayer


func _on_finished() -> void:
	self.visible = false
	$"../SombrePrintemps".visible = true
	$"../SombrePrintemps/TimerEcranTitre".start()
	self.stop()
	
