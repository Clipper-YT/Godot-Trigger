extends RefCounted
##The results of an action, stored in handy data format!
class_name ActionResult

##The name of the action.
var action_name:String
##The description of the action.
var action_description:String
##Array of EffectResult for each effect of the action.
var effect_results:Array[EffectResult]

##Returns the ActionResult as a String.
func stringify():
	var string:String
	string = "Action: " + action_name + "\n" + action_description
	var effect_index:int = 0
	for i in effect_results:
		var result:String = "\n\nEffect " + str(effect_index) + ":"
		result += "\n- Is Spell: " + str(i.is_spell)
		result += "\n- User: " + i.user.character_name
		for _char in i.targets:
			result += "\n- Target: " + _char.character.character_name
			result += "\n - - Old HP: " + str(_char.old_health)
			result += "\n - - HP Change: " + str(-_char.effective_hp_change)
			result += "\n - - Critical: " + str(_char.is_crit)
			result += "\n - - Final HP: " + str(_char.new_health)
			result += "\n - - Downed: " + str(_char.downed)
			result += "\n - - Affinity: " + _char.stringify_affinity()
		result += "\n- Additional Debug Info:\n\n" + i.additional_debug_message
		result += "\n"
		
		effect_index += 1
		string += result
	
	return string
