extends Node
# Manages the game state.

##Defines all possible states of Affinity to damage types.
enum AFFINITY {
	NORMAL,
	WEAK,
	RESIST,
	IMMUNE,
	ABSORB,
}

##Name of the currently played file
var filename:String = ""
##The time currently played
var playtime:int = 0
##The character instances for the player party.
var player_instances:Array[CharacterInstance]
##The current player inventory.
var inventory:Dictionary = {}

##Stores all possible damage types/sources of damage.
var damage_types:Array[DamageType] = [
	load("res://scripts/actions/damage_types/fire_damage.tres"),
	load("res://scripts/actions/damage_types/melee_damage.tres"),
	load("res://scripts/actions/damage_types/water_damage.tres"),
]

##The available save files.
var saves:Array = []
##The current location within the game.
var location:String = ""

##Gameplay is inactive in menus before the game is loaded; if false, stops the ticking of playtime.
var gameplay_active:bool = false
