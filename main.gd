extends Node

@export var mob_scene: PackedScene
var score

func _ready() -> void:
	new_game()


func _process(delta: float) -> void:
	pass


func _on_player_hit() -> void:
	game_over()


func game_over() -> void:
	$scoretimer.stop()
	$mobtimer.stop()


func new_game() -> void:
	score = 0
	$Player.start($startposition.position)
	$starttimer.start()


func _on_starttimer_timeout() -> void:
	$mobtimer.start()
	$scoretimer.start()


func _on_scoretimer_timeout() -> void:
	score += 1


func _on_mobtimer_timeout() -> void:
	var mob = mob_scene.instantiate()

	var mobspawnlocation = $mobPath/mobspawnlocation
	mobspawnlocation.progress_ratio = randf()

	mob.position = mobspawnlocation.position

	var direction = mobspawnlocation.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)
