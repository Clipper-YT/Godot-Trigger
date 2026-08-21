extends RefCounted
##The current state of a BattleManager, stored in handy data format!
class_name BattleState

##Defines the multiple states and outcomes of a battle. DO NOT TOUCH
##unless you know what you're doing.
enum STATE {
	ONGOING,
	WIN,
	LOSS,
	OTHER
}

##The battle manager this information is stored from.
var battle_manager:BattleManager
##The player side of the battle.
var player_side:Array[CharacterInstance]
##The enemy side of the battle.
var enemy_side:Array[CharacterInstance]
##The current state, per the ones defined in STATE.
var battle_state:STATE = STATE.ONGOING
