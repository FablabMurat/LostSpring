extends CharacterBody2D


@export var speed = 200
var arrayInput = ["left","right","top","bottom"]


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
	
	
	
	move_and_slide()
