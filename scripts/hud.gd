extends Control

############################## public variables ###############################

var analog_is_pressed = false
var frames_passed = 0




################################### signals ###################################

func _ready(): ################################################################
	load_debug_screen()


func _process(delta): #########################################################
	if has_node("/root/World/Player"):
		var Player = get_node("/root/World/Player")
		var World = get_node("/root/World")
		var XYZ = find_node("Player XYZ")
		XYZ.set_text("XYZ: " + str(Player.translation))
		#msg(str(round_vector3(Player.translation, 2.0)), "Trace")
		
		var chunk_address = find_node("Chunk Address")
		chunk_address.set_text(" == " + str(World.get_chunk(Player.translation)) + " == ")
		
		var chunk_position = find_node("Chunk XYZ")
		#chunk_position.set_text("XYZ: " + str(World.ChunkAddresses[Vector2(World.get_chunk(Player.translation).x, World.get_chunk(Player.translation).z)]))
		
		var looking_position = find_node("Looking XYZ")
		looking_position.set_text("Looking at: XYZ: " + str(Player.get_looking_at()))
		
		var looking_chunk = find_node("Looking at Chunk")
		looking_chunk.set_text("Looking at chunk: XYZ: " + str(World.get_chunk(Player.get_looking_at())))
		
		var orentation = find_node("Orentation")
		orentation.set_text("Orentation: " + Player.get_orientation())
		
		var mode = find_node("Mode")
		mode.set_text("Mode: " + Player.action_mode)
		
		var entities = find_node("Entities")
		entities.set_text("Entities: " + str(World.total_entities) + " | Players: " + str(World.total_players))
		
	var fps = find_node("FPS")
	fps.set_text("FPS: " + str(Engine.get_frames_per_second()))
	
	frames_passed+=1
	if frames_passed > 100:
		load_debug_screen()
		frames_passed = 0


func _on_AnalogTop_pressed(): #################################################
	analog_is_pressed = true


func _on_AnalogTop_released(): ################################################
	analog_is_pressed = false


func _input(event): ###########################################################
	if event is InputEventScreenDrag:
		if analog_is_pressed:
			var touch_position = event.position
			msg("Touching the Analog stick", "Debug")
			msg(touch_position, "Debug")




################################## functions ##################################

func round_vector3(vector, places): ###########################################
	#var x = round(vector.x * pow(10.0, places)) / pow(10.0, places)
	#var y = round(vector.y * pow(10.0, places)) / pow(10.0, places)
	#var z = round(vector.z * pow(10.0, places)) / pow(10.0, places)
	var x = stepify(vector.x, places)
	var y = stepify(vector.y, places)
	var z = stepify(vector.z, places)
	
	return Vector3(x, y, z)


func load_debug_screen(): ####################################################
	if has_node("/root/World"):
		var World = get_node("/root/World")
		
		var version = find_node("Version")
		version.set_text(World.version)
		
		var world_name = find_node("World Name")
		world_name.set_text(" == " + World.map_name + " == ")
		
		var world_path = find_node("World Path")
		world_path.set_text(World.map_path)
		
		var total_chunks = find_node("Total Chunks")
		total_chunks.set_text("Total chunks: " + str(World.total_chunks))
		
		var chunks_cache = find_node("Chunks Cache")
		if World.chunks_cache_size == 0:
			chunks_cache.set_text("Chunks cache: " + "none")
		else:
			chunks_cache.set_text("Chunks cache: " + str(World.chunks_cache_size))
		
		var chunks_loaded = find_node("Chunks Loaded")
		chunks_loaded.set_text("Chunks loaded: " + str(World.loaded_chunks))
		
		var map_seed = find_node("Seed")
		map_seed.set_text("Seed: " + str(World.map_seed))


func fetch_client_version(): ##################################################
	#var file = File.new()
	#if file.open("res://version.txt", File.READ) != 0:
	#	msg("Error reading client version.", "Error")
	
	#return file.get_as_text()
	var World = get_node("/root/World")
	return World.version


func show_msg(message, tag): ##################################################
	#if get_tree().get_root().has_node("/root/Main Menu/World/HUD/Chat"):
	#	var Chat = get_tree().get_root().get_node("/root/Main Menu/World/HUD/Chat")
	#	Chat.add_text(tag + ": " + str(message) + '\n')
	
	if get_tree().get_root().has_node("/root/Main Menu/UI/Home/VBoxContainer/TopContainer/Chat/VBoxContainer/Chat"):
		var Chat = get_tree().get_root().get_node("/root/Main Menu/UI/Home/VBoxContainer/TopContainer/Chat/VBoxContainer/Chat")
		Chat.add_text(tag + ": " + str(message) + '\n')
		
	elif get_tree().get_root().has_node("/root/World/HUD/Chat"):
		var Chat = get_tree().get_root().get_node("/root/World/HUD/Chat")
		Chat.add_text(tag + ": " + str(message) + '\n')


func msg(message, tag): #######################################################
	print(tag, ": ", message)
	show_msg(message, tag)



