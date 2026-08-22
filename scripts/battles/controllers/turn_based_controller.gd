extends Node
class_name TurnBasedController

var battle:BattleManager

signal turn_order_changed(turn_order:Array)

signal battle_started
signal turn_started(character:CharacterInstance)
signal turn_ended(character:CharacterInstance)

signal battle_won
signal battle_lost

var turn_order:Array[CharacterInstance] = []
var current_turn:int = -1 # -1 if uninitialized or in some weird state.

func start_battle():
	build_turn_order()
	
	current_turn = 0
	
	battle_started.emit()
	
	if !turn_order.is_empty():
		turn_started.emit(turn_order[current_turn])

func advance_turn():
	var previous = get_current_character()

	turn_ended.emit(previous)

	current_turn += 1

	if current_turn >= turn_order.size():
		current_turn = 0

	# Skip downed characters
	while get_current_character().character_down:
		current_turn += 1

		if current_turn >= turn_order.size():
			current_turn = 0

	# Check battle state
	if battle.check_victory():
		battle_won.emit()
		return

	if battle.check_defeat():
		battle_lost.emit()
		return

	turn_started.emit(get_current_character())

func submit_action(
		action:BattleAction,
		user:CharacterInstance,
		targets:Array[CharacterInstance],
		debug:bool = false
	):

	var result = battle.execute_action(
		action,
		user,
		targets,
		debug
	)
	
	if battle.check_victory():
		battle_won.emit()
		return
	
	if battle.check_defeat():
		battle_lost.emit()
		return
	
	advance_turn()
	
	return result

# Helpers

func build_turn_order():
	turn_order.clear()
	turn_order = battle.player_side + battle.enemy_side
	
	turn_order.sort_custom(
		func(a:CharacterInstance, b:CharacterInstance):
			return a.get_statistic("speed") > b.get_statistic("speed")
	)
	
	turn_order_changed.emit(turn_order)

func get_current_character() -> CharacterInstance:
	if turn_order.is_empty():
		return null # fallback; shouldn't happen

	return turn_order[current_turn]
