extends Resource
##Basic Item class. Has a name and description, can be sold/bought, has a price, and a modifier for said price.
class_name BaseItem

##The name of the item.
@export_placeholder("Leeroy Jenkins") var item_name:String
##The description of the item.
@export_placeholder("He just ran in") var item_description:String
##Bool to set if you can sell the item or not. Default true.
@export var can_sell_item:bool = true
##Price at which the player can buy this item.
@export var buy_price:int = 1
##Modifer as to how much less the item will sell for. Higher numbers mean lower price, as the formula is [code]buy_price -= (buy_price * sell_modifier)[/code].
@export_range(0.1, 1.0, 0.1) var sell_modifier:float = 0.6
