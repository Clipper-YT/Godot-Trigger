extends RefCounted
##CharacterResult subclass for character-based information.
class_name CharacterResult

##The CharacterInstance for this character.
var character:CharacterInstance
##The character's HP before the Action was applied.
var old_health:int = 0
##The character's HP after the Action was applied.
var new_health:int = 0
##The effective change in HP.
var effective_hp_change:int = 0
##True if the character was downed by this action.
var downed:bool = false
##The affinity this character had to the Action's DamageType
var affinity:GameState.AFFINITY
##True if the attack for this character was a critical hit.
var is_crit:bool = false

func stringify_affinity() -> String:
	var string:String
	match affinity:
		GameState.AFFINITY.NORMAL:
			string = "NORMAL"
		GameState.AFFINITY.WEAK:
			string = "WEAK"
		GameState.AFFINITY.RESIST:
			string = "RESIST"
		GameState.AFFINITY.IMMUNE:
			string = "IMMUNE"
		GameState.AFFINITY.ABSORB:
			string = "ABSORB"
		_:
			string = "UNKNOWN"
	return string
