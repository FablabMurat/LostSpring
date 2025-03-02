extends Node

func flowerColorUI(colorName,playerNumber) -> void:
	var uiNode = get_node("/root/Node2D/FlowerUI/FlowerUI" + playerNumber)
	uiNode.modulate = Color(colorName)
	if colorName == "none":
		uiNode.visible = false
	else:
		uiNode.visible = true
