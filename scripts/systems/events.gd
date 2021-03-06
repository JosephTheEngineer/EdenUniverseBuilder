extends Node

signal entity_loaded(entity)
signal request_entity_unload(entity)
signal scene_loaded()
signal entity_moved(entity, dir)
signal entity_used(entity, amount)
signal msg(entity, info)
signal damage_dealt(target, shooter, weapon_data)
signal damage_taken(target, shooter)
signal entity_picked_up(picker, entity)

signal gui_loaded(name, entity)
signal gui_pushed(name, init_param)
