extends AnimatedSprite2D


func _physics_process(delta):

	if self.frame == 20 && self.animation == "PopUp":
		self.animation = "Idle"
		$"../Timer".start()
	elif self.frame == 9 && self.animation == "PopDown":
		self.animation = "PopUp"
		self.stop()
		$"../Timer".stop()
	else:
		pass

func _on_timer_timeout() -> void:
	if self.animation == "Idle":
		self.animation = "PopDown"
