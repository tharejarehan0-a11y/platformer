extends Area2D

@export var speed := 400
var screen_size
@export var our_gravity := 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void: 
	if body is RigidBody2D: 
		hide()
		get_parent().game_over()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up") and $RayCast2D2.is_colliding():
		velocity.y -= our_gravity * delta
	elif not $RayCast2D.is_colliding():
		velocity.y += our_gravity * delta

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false 
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		

func start():
	show()
	position = Vector2(100, 100)
