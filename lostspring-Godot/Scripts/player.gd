extends CharacterBody2D


@export var speed = 200
var arrayInput = ["left","right","top","bottom"]
@onready var playerSprite = $AnimatedSprite2D

var grabbedFlowerColor = "none";
func _ready():
	var screen_size = get_viewport_rect().size
	print(name)
	#Recupere le numéro de joueur pour les commandes
	for i in arrayInput.size():
		var num_str: String = name
		var num: int = num_str.right(num_str.length()-9).to_int()
		arrayInput[i] = arrayInput[i] + str(num)
	
			
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
	grabbedFlowerColor = colorName
	print("grabbed flower color is " + colorName) 


func _on_flower_holder__entered(holderName: Variant) -> void:
	var holderPath = holderName.get_path()
	var animatedHolder = get_node(str(holderPath) + "/flowerHolderSprite")
	prints(str(holderPath) + "/flowerHolderSprite")
	var colorName = holderName.name.substr(12,-1)
	if colorName == grabbedFlowerColor:
		animatedHolder.play()
		print("door" + colorName + "open")
		var currentDoor = get_node(str(holderPath)+"/../Door"+colorName)
		currentDoor.set_collision_layer_value(1,0)
		var currentDoorSprite = get_node(str(currentDoor.get_path()) + "/doorSprite")
		currentDoorSprite.play()
