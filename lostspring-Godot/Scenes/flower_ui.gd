extends Node

func flowerColorUI(colorName,playerNumber) -> void:
	var uiNode = get_node("/root/Node2D/FlowerUI/FlowerUI" + str(playerNumber))
	uiNode.modulate = Color(colorName)
	if colorName == "none":
		uiNode.visible = false
	else:
		uiNode.visible = true

func endOfTheGame() -> void:
	$CreditsScreen.visible

func showMap(visibility,currentPlayer):
	$Map1.visible = visibility
