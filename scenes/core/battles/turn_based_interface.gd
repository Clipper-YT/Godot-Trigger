extends Control
# Turn Based Interface

var turn_based_controller:TurnBasedController
var battle_manager:BattleManager

func _ready() -> void:
	battle_manager = GameState.current_battle
	turn_based_controller = GameState.styled_battle
	
	match GameState.current_battle_style:
		GameState.BATTLE_STYLE.TURN_BASED_1ST_P:
			first_person_setup()
		GameState.BATTLE_STYLE.TURN_BASED_SIDE:
			pass # Setup side view
		GameState.BATTLE_STYLE.TURN_BASED_TOP_DOWN:
			pass # Setup top-down view
		_:
			push_error("Undefined Style for Turn-Based Combat")

func first_person_setup():
	var screen_center:Vector2 = Vector2i(get_viewport_rect().size/2.0)
	$EnemySide.global_position = screen_center
	var enemy_side:Array[CharacterInstance] = battle_manager.enemy_side.duplicate() # local copy to simplify; don't need direct access anyway
	for i in enemy_side.size():
		var enemies_size = enemy_side.size()
		var enemy_visual = enemy_side[i-1].visible_character_scene.instantiate()
		$EnemySide.add_child(enemy_visual)
		var offset = -((enemies_size - 1) * 256) / 2.0
		enemy_visual.global_position.x = screen_center.x + (offset * i)
		print(offset)
		print(enemy_visual.global_position.x)
