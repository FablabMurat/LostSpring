extends CharacterBody2D

signal playerDeath(playerNumber,playerPosition)
@export var speed = 200
var arrayInput = ["left","right","top","bottom"]
@onready var playerSprite = $AnimatedSprite2D
var grabbedFlowerColor = ["none","none"]
@onready var playerNumber = int(self.name.substr(6,-1))
@onready var respawnPosition = Vector2.ZERO
var playerIsOnMonster = false
var animatedMonster
var playerDeadBlind = 10
@onready var rootNode = get_node("/root/Node2D")
@onready var audioPlayerNode = get_node("/root/Node2D/AudioPlayer")
@onready var flowerUINode = get_node("/root/Node2D/AudioPlayer")
var stepIsPlaying = false
var frameNumber = 0
var playerInEnd = [false,false]
func _ready():
	var screen_size = get_viewport_rect().size
	print(name)
	if playerNumber == 1:
		playerSprite.modulate = Color.SKY_BLUE
	else:
		playerSprite.modulate = Color.ORANGE
		
	#Recupere le numéro de joueur pour les commandes
	for i in arrayInput.size():
		var num_str: String = name
		var num: int = num_str.right(num_str.length()-9).to_int()
		arrayInput[i] = arrayInput[i] + str(num)
	respawnPosition = Vector2(self.position)
	print("respawn point start " + "player" + str(playerNumber) +" " + str(respawnPosition))
func _physics_process(delta):
	
	var direction = Vector2(0,0)

		
	#Inputs

	direction.x = Input.get_axis(arrayInput[0],arrayInput[1])
	direction.y = Input.get_axis(arrayInput[2],arrayInput[3])
	
	velocity.x = int(speed * direction.x)
	velocity.y = int(speed * direction.y)
	
	if direction == Vector2(0,0):
		if playerSprite.animation == "runSide":
			playerSprite.animation = "idleSide"
		else:
			playerSprite.animation = "idleFace"
	if direction.x < 0:
		playerSprite.flip_h = true
		playerSprite.animation = "runSide"
	elif direction.x > 0:
		playerSprite.flip_h = false
		playerSprite.animation = "runSide"
	elif direction.y > 0:
		playerSprite.animation = "runDown"
	elif direction.y < 0:
		playerSprite.animation = "runUp"
	playerSprite.play()
	
	if velocity != Vector2.ZERO && stepIsPlaying== false:
		stepIsPlaying = true
		audioPlayerNode.playAudio("step" + str(playerNumber))
	if velocity == Vector2.ZERO && stepIsPlaying== true:
		stepIsPlaying = false
		audioPlayerNode.pauseAudio("step" + str(playerNumber))
	move_and_slide()

	if playerIsOnMonster && animatedMonster.animation == "Idle":
		self.position = respawnPosition
		playerDeath.emit(self,self.position)
		$Timer.start()
		animatedMonster.animation = "PopUp"
		playerIsOnMonster = false
		
	if playerInEnd== [true,true]:
		pass


	


func _on_flower_yellow__entered(flowerName: Variant,body) -> void:
	var currentPlayerNumber = int(body.name.substr(6,-1))
	if playerNumber == currentPlayerNumber:
		var flowerPath = flowerName.get_path()
		var animatedFlower = get_node(str(flowerPath) + "/flowerSprite")
		prints(str(flowerPath) + "/flowerSprite")
		animatedFlower.play()
		var colorName = flowerName.name.substr(6,-1)
		flowerName.visible = false
		grabbedFlowerColor[currentPlayerNumber-1] = colorName
		audioPlayerNode.playAudio("flower")

func _on_flower_holder__entered(holderName: Variant,body) -> void:
	var currentPlayerNumber = int(body.name.substr(6,-1))
	if playerNumber == currentPlayerNumber:
		var holderPath = holderName.get_path()
		var animatedHolder = get_node(str(holderPath) + "/flowerHolderSprite")
		prints(str(holderPath) + "/flowerHolderSprite")
		var colorName = holderName.name.substr(12,-1)
		if colorName == grabbedFlowerColor[playerNumber-1]:
			animatedHolder.play()
			print("door" + colorName + "open")
			var currentDoor = get_node(str(holderPath)+"/../Door"+colorName)
			currentDoor.set_collision_layer_value(1,0)
			var currentDoorSprite = get_node(str(currentDoor.get_path()) + "/doorSprite")
			currentDoorSprite.play()
			grabbedFlowerColor[currentPlayerNumber-1] = "none"
			respawnPosition = body.position
			frameNumber = 1
			rootNode.chooseFrameText(frameNumber,currentPlayerNumber)
			$"../TimerFrame".start()
			audioPlayerNode.playAudio("holder")



func _on_monster__entered(monsterName: Variant,body) -> void:
	var monsterPath = monsterName.get_path()
	var currentPlayerNumber  = int(body.name.substr(6,-1))
	if playerNumber == currentPlayerNumber:
		audioPlayerNode.playAudio("monster")
		playerIsOnMonster = true
		print("monster entered by player " + str(currentPlayerNumber))
		animatedMonster = get_node(str(monsterPath) + "/monsterSprite")
	
		if animatedMonster.is_playing() == false:
			animatedMonster.animation = "PopUp"
		animatedMonster.speed_scale = 1
		animatedMonster.play()
		print("player number" + body.name + str(respawnPosition))


func _on_monster__exited(monsterName: Variant, body: Variant) -> void:
	var currentPlayerNumber  = int(body.name.substr(6,-1))
	if currentPlayerNumber == playerNumber:
		playerIsOnMonster = false


func _on_timer_timeout() -> void:
	if playerDeadBlind != 0:
		playerDeadBlind -= 1
		$Timer.start()
		self.visible = !self.visible
	else:
		playerDeadBlind = 10
		
		$Timer.stop()


func _on_timer_frame_timeout() -> void:
	var currentPlayerNumber = int(self.name.substr(6,-1))
	if frameNumber == 2:
		frameNumber = 0
		rootNode.chooseFrameText(frameNumber,currentPlayerNumber)
		audioPlayerNode.playAudio("doorOpen")
	if frameNumber == 1:
		frameNumber = 2
		print("passage frame i a 2")
		rootNode.chooseFrameText(frameNumber,currentPlayerNumber)
		$"../TimerFrame".start()


	
	


func _on_map_show__entered_map(emitter: Variant, body: Variant) -> void:
	var currentPlayerNumber  = int(body.name.substr(6,-1))
	rootNode.showMap(true,currentPlayerNumber)


func _on_map_show__exited_map(emitter: Variant, body: Variant) -> void:
	var currentPlayerNumber  = int(body.name.substr(6,-1))
	rootNode.showMap(false,currentPlayerNumber)


func _on_level_end_body_entered(body: Node2D) -> void:
	var currentPlayerNumber = int(body.name.substr(6,-1))
	if currentPlayerNumber == playerNumber:
		playerInEnd[playerNumber] = true


func _on_level_end_body_exited(body: Node2D) -> void:
	var currentPlayerNumber = int(body.name.substr(6,-1))
	if currentPlayerNumber == playerNumber:
		playerInEnd[currentPlayerNumber] = true
	
