extends BaseItem
##A weapon item. Has a damage amount, crit multiplier, and crit chance.
class_name WeaponItem

##The base amount of damage the weapon deals.
@export var weapon_damage:int = 1
##Value multiplied to [code]weapon_damage[/code] which results in the damage dealt by a critical hit with this weapon.
@export_range(1.0, 3.0, 0.2) var weapon_crit_multiplier:float = 2.0
##The chance for a hit to be a critical hit with this weapon.
@export_range(0.1, 0.7, 0.02) var weapon_crit_chance:float = 0.1
##Statistic modifiers applied by this item.
@export var stat_modifiers:Array[StatModifier] = []
