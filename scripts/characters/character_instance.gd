extends Node
##A class for loading and managing CharacterResource data.
class_name CharacterInstance

# NOTE: May be unnecessary
#signal character_initialized
##Emitted if the character is downed.
signal character_downed(character:CharacterInstance)

##The affinities of this character. Defaults to NORMAL if unset.
var affinities:Dictionary[DamageType,GameState.AFFINITY] = {}

##The Resource used as the base for the character, if that method was used to initialize.
var character_resource:CharacterResource

##The character's name.
var character_name:String
##The character's statistics, as a StatisticInstance.
var character_statistics:StatisticInstance
##The character's currently equipped weapon.
var character_weapon:WeaponItem
##The character's currently equipped head armor piece.
var character_armor_head:ArmorItem
##The character's currently equipped chest armor piece.
var character_armor_chest:ArmorItem
##The character's currently equipped special armor piece.
var character_armor_special:ArmorItem

# Other variables

##The current state of the Active Time Battle gauge, if it is the combat system in use.
var atb_gauge_state:int = 0
##Variable for the player being ready in Active Time Battle.
var atb_ready:bool = false

##Variable for the character being down in combat or not.
var character_down := false

##Gets a statistic from its name. Has the option to ignore armor modifiers and return the character's base statistic.
func get_statistic(statistic_name:String, include_armor_modifiers:bool = true):
	var final_stat:int = character_statistics.get(statistic_name)
	var armor_modifiers:Array[StatModifier] = character_armor_head.stat_modifiers + character_armor_chest.stat_modifiers + character_armor_special.stat_modifiers + character_weapon.stat_modifiers
	
	for i in armor_modifiers:
		if i.modified_statistic == statistic_name:
			if i.percentage:
				final_stat += final_stat * floori(float(i.modifier_amount)/100.0)
			else:
				final_stat += i.modifier_amount
	return final_stat if include_armor_modifiers else character_statistics.get(statistic_name)

##Initializes the character from the given [code]CharacterResource[/code].
func initialize_from_resource(res:CharacterResource):
	character_resource = res
	
	character_name = res.character_name
	character_statistics = StatisticInstance.new()
	character_statistics.initialize_from_resource(res.character_statistics)
	character_weapon = res.character_weapon
	character_armor_head = res.character_armor_head
	character_armor_chest = res.character_armor_chest
	character_armor_special = res.character_armor_special
	
	if !character_armor_head:
		character_armor_head = ArmorItem.new()
	if !character_armor_chest:
		character_armor_chest = ArmorItem.new()
	if !character_armor_special:
		character_armor_special = ArmorItem.new()
	if !character_weapon:
		character_weapon = WeaponItem.new()
	
	for i in GameState.damage_types:
		if !(i in res.affinities):
			affinities[i] = GameState.AFFINITY.NORMAL
		else:
			affinities[i] = res.affinities[i]
	
	#character_initialized.emit()

##Deals the specified amount of damage, and downs the character if HP drops below 1.
func take_damage(damage_amount:int):
	character_statistics.current_health_points -= damage_amount
	if character_statistics.current_health_points < 1:
		character_down = true
		character_downed.emit(self)

##Heals the specified amount of HP, and unsets character_down if applicable.
func heal(heal_amount:int):
	character_statistics.current_health_points += heal_amount
	if character_statistics.current_health_points > character_statistics.max_health_points:
		character_statistics.current_health_points = character_statistics.max_health_points
	if character_statistics.current_health_points > 0:
		character_down = false

##Sets the character's HP to the given amount, and unsets character_down.
func revive_with_amount(heal_amount:int):
	set_hp_to_zero()
	heal(heal_amount)
	character_down = false

##Sets the character's HP to zero. Not sure why you'd need this outside of other functions.
func set_hp_to_zero():
	character_statistics.current_health_points = 0
