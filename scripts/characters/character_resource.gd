extends Resource
##Base Resource for Character data, loaded through the CharacterInstance class.
class_name CharacterResource

@export_placeholder("Leeroy Jenkins") var character_name:String
@export var character_statistics:StatisticResource
@export var character_weapon:WeaponItem
@export var character_armor_head:ArmorItem
@export var character_armor_chest:ArmorItem
@export var character_armor_special:ArmorItem
# TODO: Separate the ArmorItem into three types, although this could be done within the same Resource.
