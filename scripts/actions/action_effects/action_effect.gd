extends Resource
##Base class for defining the effects of actions. To be used by BattleAction.
class_name ActionEffect

##Applies the effect, does calculations with the user and the targets.
func apply(
			user:CharacterInstance,
			targets:Array[CharacterInstance],
			#battle:BattleManager - Don't need this yet
		):
	pass
