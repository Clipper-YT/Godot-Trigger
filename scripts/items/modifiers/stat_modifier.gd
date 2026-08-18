extends ItemModifier
##An ItemModifier meant to modify statistics.
class_name StatModifier

##The statistic modified by this modifier.
@export_enum("max_health_points", "max_magic_points", "attack", "defense", "speed", "magic", "critical") var modified_statistic:String = "speed"
##If the modifier amount is applied as a percentage increase instead of flat addition.
##BE CAREFUL WITH THIS DUE TO BALANCING!
@export var percentage:bool = false
##The amount applied by the modifier.
@export var modifier_amount:int = 1
