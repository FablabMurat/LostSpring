extends Node
var endGame = [false,false]
var endMusicPlay = false
func flowerColorUI(colorName,playerNumber) -> void:
	var uiNode = get_node("/root/Node2D/UI/FlowerUI" + str(playerNumber))
	uiNode.modulate = Color(colorName)
	if colorName == "none":
		uiNode.visible = false
	else:
		uiNode.visible = true

func endOfTheGame(playerState,playerNumber) -> void:
	endGame[playerNumber -1] = playerState
	if endGame == [true,true] && endMusicPlay == false:
		$CreditsScreen/Timer.start()
		$"../AudioPlayer/EndMusic".play()
		$"../AudioPlayer/Ambiance".stop()
		endMusicPlay = true
		

func showMap(visibility,currentPlayer) -> void:
	var mapNode = get_node("/root/Node2D/UI/Map" + str(currentPlayer))
	print("map displayed path is " + "/root/Node2D/UI/Map" + str(currentPlayer) + " map is " + str(visibility))
	if visibility == true:
		mapNode.visible = true
	else:
		mapNode.visible = false


func _on_timer_timeout() -> void:
	$CreditsScreen.visible = true
