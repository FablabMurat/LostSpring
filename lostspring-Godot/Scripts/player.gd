extends CharacterBody2D


@export var speed = 200
var arrayInput = ["left","right","top","bottom"]
@onready var playerSprite = $AnimatedSprite2D
var flowerArray = []
func _ready():
	var screen_size = get_viewport_rect().size
	print(name)
	#Recupere le numéro de joueur pour les commandes
	for i in arrayInput.size():
		var num_str: String = name
		var num: int = num_str.right(num_str.length()-9).to_int()
		arrayInput[i] = arrayInput[i] + str(num)
	var grid_width = 2
	var flowerNumber = 5
	for i in grid_width:
		flowerArray.append([])
		for j in flowerNumber:
			flowerArray[i].append(0) # Set a starter value for each position
			print("entrée fleurs" + str(flowerArray[i][j]))
			
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
	
	move_and_slide()




func _on_flower_yellow__entered(flowerName: Variant) -> void:
	var flowerPath = flowerName.get_path()
	var animatedFlower = get_node(str(flowerPath) + "/flowerSprite")
	prints(str(flowerPath) + "/flowerSprite")
	animatedFlower.play()
	var colorName = flowerName.name.substr(6,-1)
	
	
