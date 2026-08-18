extends Resource
##Base Resource for Character data, loaded through the CharacterInstance class.
class_name CharacterResource

##The character's name.
@export_placeholder("Leeroy Jenkins") var character_name:String
##The character's statistics, as a StatisticResource.
@export var character_statistics:StatisticResource
##The character's currently equipped weapon.
@export var character_weapon:WeaponItem
##The character's currently equipped head armor piece.
@export var character_armor_head:ArmorItem
##The character's currently equipped chest armor piece.
@export var character_armor_chest:ArmorItem
##The character's currently equipped special armor piece.
@export var character_armor_special:ArmorItem
##List of affinities to specific damage types.
@export var affinities:Dictionary[DamageType,GameState.AFFINITY] = {}
