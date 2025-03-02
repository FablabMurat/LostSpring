extends Node2D
@onready var players := {
	"1": {
		viewport = $HBoxContainer/SubViewportContainer/Viewport1,
		camera = $HBoxContainer/SubViewportContainer/Viewport1/Camera1,
		player = $HBoxContainer/SubViewportContainer/Viewport1/Level/Player2
	},
	"2": {
		viewport = $HBoxContainer/SubViewportContainer2/Viewport2,
		camera = $HBoxContainer/SubViewportContainer2/Viewport2/Camera2,
		player = $HBoxContainer/SubViewportContainer/Viewport1/Level/Player1
	}
}

var frame = 0
var playerNumber = 0
func _ready() -> void:
	# The world_2d object of the viewport contains information about what to
	# render. Here, it's our game level. We need to pass it from the first to
	# the second viewport for both of them to render the same level.
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	# For each player, we create a remote transform that pushes the character's
	# position to the corresponding camera.
	#for node in players.values():
		#var remote_transform := RemoteTransform2D.new()
		#remote_transform.remote_path = node.camera.get_path()
		#node.player.add_child(remote_transform)


func _process(delta: float) -> void:
	var screenWidth = 176;
	var screenHeight = 176;
	var player2X = players["2"].player.position.x
	var player2Y = players["2"].player.position.y
	var yOffset = 5-8*2;
	var xOffset = 8*2;
	var newPlayer2X = (floor((player2X-xOffset*2)/screenWidth))*screenWidth+xOffset;
	players["2"].camera.position.x = newPlayer2X-floor(screenWidth/2)+8;
	
	var newPlayer2Y = floor(player2Y/screenHeight)*screenHeight-yOffset;
	players["2"].camera.position.y = newPlayer2Y-floor(screenHeight/2)+40;
	var player1X = players["1"].player.position.x
	var player1Y = players["1"].player.position.y
	yOffset = 5-8*2;
	xOffset = 8*2;
	var newPlayer1X = (floor((player1X-xOffset*2)/screenWidth))*screenWidth+xOffset;
	var newPlayer1Y = floor(player1Y/screenHeight)*screenHeight-yOffset;
	players["1"].camera.position.x = newPlayer1X-floor(screenWidth/2)+12;
	players["1"].camera.position.y = newPlayer1Y-floor(screenHeight/2)+40;

func chooseFrameText(newframe,currentPlayer):
	frame = newframe
	playerNumber = currentPlayer
	print("image numero " + str(newframe) + " by player : " + str(playerNumber))
	if currentPlayer == 1:
		$PlayerFrame192x217.frame = frame
	if currentPlayer == 2:
		$PlayerFrame192x216.frame = frame
