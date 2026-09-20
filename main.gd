extends Node

@export var mob_scene: PackedScene

func game_over():
	$Label.show()
	$Button.show()

func _ready() -> void:
	$Label.hide()
	$Button.hide()

func _on_object_timer_timeout():

	var obstacle = mob_scene.instantiate()
	add_child(obstacle)

	obstacle.position = Vector2(
		-50,
		randf_range(500, 500)
	)

	obstacle.linear_velocity = Vector2(400, 00)


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
