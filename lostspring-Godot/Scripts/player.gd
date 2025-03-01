extends CharacterBody2D


@export var speed = 200



func _ready():
	var screen_size = get_viewport_rect().size


func _physics_process(delta):
	
	var direction = Vector2(0,0)
	
	
	direction.x = Input.get_axis("left1","right1")
	direction.y = Input.get_axis("top1","bottom1")
	velocity = speed * direction
	
	
	
	move_and_slide()
