extends AnimatedSprite2D


func _physics_process(delta):

	if self.frame == 20 && self.animation == "PopUp":
		self.animation = "Idle"
		$"../Timer".start()

func _on_timer_timeout() -> void:
	self.animation = "PopDown"
