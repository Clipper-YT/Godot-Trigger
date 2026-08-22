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

##Defines all possible styles of battle.
enum BATTLE_STYLE {
	TURN_BASED_1ST_P = 0,
	TURN_BASED_SIDE = 1,
	TURN_BASED_TOP_DOWN = 2,
	ATB_V1 = 3,
	ATB_V2 = 4,
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
var damage_types:Array[DamageType] = [ # NOTE: These types are examples!
	load("res://data/damage_types/fire_damage.tres"),
	load("res://data/damage_types/melee_damage.tres"),
	load("res://data/damage_types/water_damage.tres"),
]

##The available save files.
var saves:Array = []
##The current location within the game.
var location:String = ""

##Gameplay is inactive in menus before the game is loaded; if false, stops the ticking of playtime.
var gameplay_active:bool = false

##The style of battle used by the framework.
##
##0 = Turn-Based, Dragon Quest/Earthbound style (first-person view)
##
##1 = Turn-Based, Final Fantasy I-III/Shin Megami Tensei style (side view)
##
##2 = Turn-Based, Breath of Fire/Ultima style (top-down view)
##
##3 = Active Time Battle Ver. 1, Final Fantasy IV-VI-style
##
##4 = Active Time Battle Ver. 2, Chrono Trigger-style (NOTE: Separate Battle Screen is force set to false for this style.)
const DEFAULT_BATTLE_STYLE:int = BATTLE_STYLE.TURN_BASED_1ST_P
##The current battle style being used; can differ from the default.
var current_battle_style:int = DEFAULT_BATTLE_STYLE
##True if the battle uses a separate screen for battles. Forced off for Active Time Battle Ver. 2, optional for others.
var separate_battle_screen:bool = true

##The current battle, if active.
var current_battle:BattleManager
##The current battle system, if active.
var styled_battle

##Starts a battle with the player party, the given enemies, and an optional battle style if different from the default.
func start_battle(
			enemies:Array[CharacterInstance],
			style:int = DEFAULT_BATTLE_STYLE
		):
	current_battle_style = style
	match style:
		BATTLE_STYLE.TURN_BASED_1ST_P,\
		BATTLE_STYLE.TURN_BASED_SIDE,\
		BATTLE_STYLE.TURN_BASED_TOP_DOWN:
			current_battle = BattleManager.new()
			styled_battle = TurnBasedController.new()
			styled_battle.battle = current_battle
			current_battle.add_all_characters(
					player_instances,
					enemies
				)
			await get_tree().create_timer(0.1).timeout
			get_tree().change_scene_to_file("res://scenes/core/battles/turn_based_battle.tscn") # NOTE: this changes later to a different system allowing for transitions from the overworld.
			styled_battle.start_battle()
		BATTLE_STYLE.ATB_V1, BATTLE_STYLE.ATB_V2:
			pass # TODO: setup later; ATB doesn't exist
		_:
			push_error("Undefined Style for Battle")
			# TODO: add better handling and a note for the user that they can add their battle style here

func _ready() -> void:
	pass
