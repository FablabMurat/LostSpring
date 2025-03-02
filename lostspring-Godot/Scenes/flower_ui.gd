extends Node
var endGame = [false,false]
func flowerColorUI(colorName,playerNumber) -> void:
	var uiNode = get_node("/root/Node2D/FlowerUI/FlowerUI" + str(playerNumber))
	uiNode.modulate = Color(colorName)
	if colorName == "none":
		uiNode.visible = false
	else:
		uiNode.visible = true

func endOfTheGame(playerState,playerNumber) -> void:
	endGame[playerNumber -1] = playerState
	print(str(endGame))
	if endGame == [true,true]:
		print("game ended")
		$CreditsScreen.visible = true

func showMap(visibility,currentPlayer):
	$Map1.visible = visibility
