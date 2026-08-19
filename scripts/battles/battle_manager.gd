extends Node
##The base class for everything battle system.
class_name BattleManager

##The total XP pool given to the player side.
var xp_pool:int = 0

##The player side of the battle.
var player_side:Array[CharacterInstance] = []
##The enemy side of the battle.
var enemy_side:Array[CharacterInstance] = []

##Adds the given character to the player side.
func add_player_character(character:CharacterInstance):
	player_side.append(character)

##Adds the given character to the enemy side.
func add_enemy_character(character:CharacterInstance):
	enemy_side.append(character)

##Adds all given characters to the [code]BattleManager[/code]. Takes two Arrays of [code]CharacterInstance[/code]: the first Array is for the player side, the second for the enemies.
func add_all_characters(
			player_characters:Array[CharacterInstance], enemy_characters:Array[CharacterInstance]
		):
	for p in player_characters:
		add_player_character(p)
	for e in enemy_characters:
		add_enemy_character(e)

##Executes a [code]BattleAction[/code] coming from the user and affecting the targets.
func execute_action(action:BattleAction, user:CharacterInstance, targets:Array[CharacterInstance]):
	var results:Array
	
	for fx in action.effects:
		results.append(fx.apply(user, targets))
	
	return results

##Returns true if either the player side is empty or all characters on that side are down.
func check_defeat():
	if !player_side.is_empty(): # NOTE: Possibly redundant; player side would stay down
		for i in player_side:
			if !i.character_down:
				return false
	return true

##Returns true if either the enemy side is empty or all characters on that side are down.
func check_victory():
	if !enemy_side.is_empty(): # NOTE: Possibly redundant
		for i in enemy_side:
			if !i.character_down:
				return false
	return true

##Gets all valid targets for attack on the player side.
func get_valid_player_targets() -> Array[CharacterInstance]:
	var targets:Array[CharacterInstance] = []
	for i in player_side:
		if !i.character_down:
			targets.append(i)
	return targets

##Gets all valid targets for attack on the enemy side.
func get_valid_enemy_targets() -> Array[CharacterInstance]:
	var targets:Array[CharacterInstance] = []
	for i in enemy_side:
		if !i.character_down:
			targets.append(i)
	return targets

# NOTE: These next two functions are here for the sake of completeness; these might not be used in the actual battle implementations.

##Removes the given character from the player side.
func remove_character_from_players(character:CharacterInstance):
	if character in player_side:
		var location = player_side.find(character)
		player_side.remove_at(location)

##Removes the given character from the enemy side.
func remove_character_from_enemies(character:CharacterInstance):
	if character in enemy_side:
		var location = enemy_side.find(character)
		enemy_side.remove_at(location)

# TODO: Move to TurnBasedController:
#signal characters_initialized(characters:Array)
#var turn_order:Array[CharacterInstance] = [] 
#func initialize_characters():
	#turn_order.clear()
	#turn_order = player_side + enemy_side
	#
	#turn_order.sort_custom(
		#func(a:CharacterInstance, b:CharacterInstance):
			#return a.get_statistic("speed") > b.get_statistic("speed")
	#)
	#
	#characters_initialized.emit(turn_order)
