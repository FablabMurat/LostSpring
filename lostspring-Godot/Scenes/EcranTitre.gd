extends Sprite2D
	
var isFading = false
var t=0
func _process(delta: float) -> void:
	if isFading==true:
		t += delta * 0.7
		self.modulate = Color(1,1,1,1).lerp(Color(1,1,0,0),t)

func _on_timer_ecran_titre_timeout() -> void:
	isFading = true
