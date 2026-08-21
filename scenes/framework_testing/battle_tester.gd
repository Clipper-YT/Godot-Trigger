extends Control

var battle:BattleManager

func _ready() -> void:
	randomize()
	_base_functionality_test()

func start_battle():
	battle = BattleManager.new()

func _base_functionality_test() -> void:
	start_battle()
	
	var player_side:Array[CharacterInstance] = []
	var ps1:CharacterInstance = CharacterInstance.new()
	ps1.initialize_from_resource(load("res://scripts/battles/battle_tester_characters/player_side_1.tres"))
	player_side.append(ps1)
	var ps2:CharacterInstance = CharacterInstance.new()
	ps2.initialize_from_resource(load("res://scripts/battles/battle_tester_characters/player_side_2.tres"))
	player_side.append(ps2)
	var es1:CharacterInstance = CharacterInstance.new()
	var enemy_side:Array[CharacterInstance] = []
	es1.initialize_from_resource(load("res://scripts/battles/battle_tester_characters/enemy_side_1.tres"))
	enemy_side.append(es1)

	battle.add_all_characters(player_side, enemy_side)
	#battle.initialize_characters()
	
	battle.execute_action(load("res://data/battle_actions/damage/melee_hit.tres"), ps1, [es1], true)
	battle.execute_action(load("res://data/battle_actions/damage/fireball.tres"), ps2, [es1], true)
	battle.execute_action(load("res://data/battle_actions/healing/generic_heal_spell.tres"), es1, [es1], true)
	#print(battle.turn_order)
