extends Spatial

onready var chunk_template = preload("res://scenes/chunk.tscn")
var world_seed = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var chunk = chunk_template.instance()
	add_child(chunk)
	

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	if (Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()