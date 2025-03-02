extends Node
func playAudio(file):
	var audioNode = get_node("/root/Node2D/AudioPlayer/" + file)
	print("AudioPlayer/" +file)
	audioNode.play()
	#$step1.stream.loop = 1
func pauseAudio(file):
	$step1.stop()
	#$step1.stream.loop = 1
