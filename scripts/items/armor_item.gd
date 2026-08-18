extends BaseItem
##An armor item. Has a base defense value.
class_name ArmorItem

##Base defense value of this armor item.
@export var armor_defense:int = 1
##Slot in which this armor item can be placed.
@export_enum("HEAD", "CHEST", "SPECIAL", "ANY") var slot:String = "ANY"
##Statistic modifiers applied by this item.
@export var stat_modifiers:Array[StatModifier] = []
