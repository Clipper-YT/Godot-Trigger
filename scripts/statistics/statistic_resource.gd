extends Resource
##Statistic resource for loading into Characters through the StatisticInstance class.
class_name StatisticResource

@export_category("Limited Statistics")
##Health Points are a standard way of managing a character's health. This stat dictates the maximum amount for a character.
@export var max_health_points:int = 20
##Magic Points, a standard way of limiting a character's spellcasting by tying it to a consumable. This stat dictates the maximum amount for a character.
@export var max_magic_points:int = 5

@export_category("Progressive Statistics")
##Attack, a standard statistic generally dictating how hard a character can hit.
@export var attack:int = 1
##Defense, a standard statistic generally dictating how much damage a character can tolerate or reduce.
@export var defense:int = 1
##Speed, a standard statistic generally dictating how fast a character can act, or the turn order of a battle.
@export var speed:int = 1
##Magic, a standard statistic generally dictating the power that magic spells have.
@export var magic:int = 1
##Critical is a modifier to the chance of any hit being a Critical Hit.
@export var critical:int = 1

@export_category("Leveling Statistics")
##The character's level, also used as a multiplier for experience given upon defeat, if this character is an enemy.
@export var level:int = 1
##The amount of experience points this character has, reset to 0 upon level up, also used as the base amount of experience given upon defeat, if this character is an enemy.
@export var experience:int = 0
