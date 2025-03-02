extends AudioStreamPlayer

var isFading = false
var t=0
var startVolume = 1.0



func _process(delta: float) -> void:
	if isFading==true:
		t += delta * 0.7
		$"../Start Music".volume_db = lerp(1.0,0.0,t)
		print("is fading at sound " + str($"../Start Music".volume_db))
		self.volume_db = lerp(0.0,1.0,t)
	if $"../Start Music".volume_db < 0.001 && isFading == true:
		isFading = false
		$"../Start Music".stop()
	
func _on_timer_ecran_titre_timeout() -> void:
	isFading=true
	self.play()
