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


func _ready() -> void:
	# The world_2d object of the viewport contains information about what to
	# render. Here, it's our game level. We need to pass it from the first to
	# the second viewport for both of them to render the same level.
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	# For each player, we create a remote transform that pushes the character's
	# position to the corresponding camera.
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
