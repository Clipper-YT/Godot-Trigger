extends ActionEffect
##ActionEffect for healing characters.
class_name HealEffect

##The amount of health restored.
@export var heal_amount:int = 1
##Notes if the healing comes from a spell or not.
@export var is_spell:bool = false
##Allows healing of downed characters.
@export var heal_downed:bool = false
##Allows healing of non-downed characters.
@export var heal_living:bool = true

func apply(
			user:CharacterInstance,
			targets:Array[CharacterInstance],
			#battle:BattleManager - don't need this yet
		):
	var result := EffectResult.new()
	var debug_string:String = ""
	
	result.user = user
	result.is_spell = is_spell
	
	var heal_number:int = floori(user.get_statistic("magic") * heal_amount/2.0) if is_spell else heal_amount
	
	for i in targets:
		var character := CharacterResult.new()
		character.character = i
		character.old_health = i.get_statistic("current_health_points")
		character.effective_hp_change = heal_number
		
		if heal_living && !i.character_down:
			i.heal(heal_number)
		elif heal_downed && i.character_down:
			i.character_statistics.current_health_points = 0
			i.revive_with_amount(heal_number)
			debug_string += "Revived " + i.character_name + "\n"
		else: # fallback
			i.heal(heal_number)
		
		character.downed = i.character_down
		
		character.new_health = i.get_statistic("current_health_points")
	
	result.additional_debug_message = debug_string if !debug_string.is_empty() else "None"
	return result
