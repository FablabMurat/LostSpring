extends CharacterBody2D


@export var speed = 200
var arrayInput = ["left","right","top","bottom"]
@onready var playerSprite = $AnimatedSprite2D


func _ready():
	var screen_size = get_viewport_rect().size
	print(name)
	#Recupere le numéro de joueur pour les commandes
	for i in arrayInput.size():
		var num_str: String = name
		var num: int = num_str.right(num_str.length()-9).to_int()
		print(num)
		arrayInput[i] = arrayInput[i] + str(num)
		print(arrayInput[i])
func _physics_process(delta):
	
	var direction = Vector2(0,0)

		
	#Inputs

	direction.x = Input.get_axis(arrayInput[0],arrayInput[1])
	direction.y = Input.get_axis(arrayInput[2],arrayInput[3])
	velocity = speed * direction
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
		playerSprite.animation = "runUp"
	elif direction.y < 0:
		playerSprite.animation = "runDown"
	playerSprite.play()
	
	move_and_slide()
