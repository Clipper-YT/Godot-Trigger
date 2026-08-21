extends Node
##A class for loading and managing StatisticResource or saved statistic data for use in Characters.
class_name StatisticInstance

##Emitted once the instance is ready for use.
signal statistic_instance_ready

##The statistic resource used to load this instance.
var statistic_resource:StatisticResource

# Limited Statistics

##Health Points are a standard way of managing a character's health. This stat dictates the maximum amount for a character.
var max_health_points:int = 20
##Health Points are a standard way of managing a character's health. This stat dictates the current amount for a character.
var current_health_points:int = 20
##Magic Points, a standard way of limiting a character's spellcasting by tying it to a consumable. This stat dictates the maximum amount for a character.
var max_magic_points:int = 5
##Magic Points, a standard way of limiting a character's spellcasting by tying it to a consumable. This stat dictates the current amount for a character.
var current_magic_points:int = 5

# Progressive Statistics

##Attack, a standard statistic generally dictating how hard a character can hit.
var attack:int = 1
##Defense, a standard statistic generally dictating how much damage a character can tolerate or reduce.
var defense:int = 1
##Speed, a standard statistic generally dictating how fast a character can act, or the turn order of a battle.
var speed:int = 1
##Magic, a standard statistic generally dictating the power that magic spells have.
var magic:int = 1
##Critical is a modifier to the chance of any hit being a Critical Hit.
var critical:int = 1

# Leveling Statistics

##The character's level, also used as a multiplier for experience given upon defeat, if this character is an enemy.
var level:int = 1
##The amount of experience points this character has, reset to 0 upon level up, also used as the base amount of experience given upon defeat, if this character is an enemy.
var experience:int = 0

##Initializes this instance from a StatisticResource.
func initialize_from_resource(resource:StatisticResource):
	statistic_resource = resource
	
	max_health_points     = resource.max_health_points
	current_health_points = max_health_points
	max_magic_points      = resource.max_magic_points
	current_magic_points  = max_magic_points
	attack     = resource.attack
	defense    = resource.defense
	speed      = resource.speed
	magic      = resource.magic
	critical   = resource.critical
	level      = resource.level
	experience = resource.experience
	
	statistic_instance_ready.emit()

##Initializes from manually inputted integers; used for loading from a save file.
func initialize_from_individual_input(
			new_max_health_points:int,
			new_max_magic_points:int,
			new_attack:int,
			new_defense:int,
			new_speed:int,
			new_magic:int,
			new_critical:int,
			new_level:int,
			new_experience:int,
			new_current_hp:int = -1,
			new_current_ep:int = -1
			):
	max_health_points     = new_max_health_points
	current_health_points = max_health_points\
			if new_current_hp == -1 else new_current_hp
	max_magic_points      = new_max_magic_points
	current_magic_points  = max_magic_points\
			if new_current_ep == -1 else new_current_ep
	attack     = new_attack
	defense    = new_defense
	speed      = new_speed
	magic      = new_magic
	critical   = new_critical
	level      = new_level
	experience = new_experience
	
	statistic_instance_ready.emit()

##Initializes from an existing instance
func initialize_from_instance(inst:StatisticInstance):
	set_from_instance(inst)
	statistic_instance_ready.emit()

##Sets the values from an existing instance.
func set_from_instance(inst:StatisticInstance):
	max_health_points     = inst.max_health_points
	current_health_points = inst.current_health_points
	max_magic_points      = inst.max_magic_points
	current_magic_points  = inst.current_magic_points
	attack     = inst.attack
	defense    = inst.defense
	speed      = inst.speed
	magic      = inst.magic
	critical   = inst.critical
	level      = inst.level
	experience = inst.experience
