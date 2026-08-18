extends Node
# Manages the game state.

##Name of the currently played file
var filename:String = ""
##The time currently played
var playtime:int = 0
##The character instances for the player party.
var player_instances:Array[CharacterInstance]
##The current player inventory.
var inventory:Dictionary = {}

##The available save files.
var saves:Array = []
##The current location within the game.
var location:String = ""

##Gameplay is inactive in menus before the game is loaded; if false, stops the ticking of playtime.
var gameplay_active:bool = false
