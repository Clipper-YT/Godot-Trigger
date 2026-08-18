extends Node
##Class to define the information that is saved and loaded within a single save file. Has a unique identifier, or "slot number". Allows for multiple files to be saved and multiple save slots.
class_name SaveData

##Unique identifier to separate self from other files/slots.
var slot_number:int = -1 # not set yet
##The actual save data.
var save_data:Dictionary = {}

''' Multiline comment to explain the structure:

save_data = {
	"save_version" : "v1" # String, currently v1
	"slot_name" : "", # The slot name (a String) chosen by the player for this file, separate from the slot number (which is the number in the filename).
	"playtime" : 0, # int that later gets split into days/hours/minutes. Choosing to not keep track of seconds.
	"player_statistics" : [ # Array, hardcoded ordering. Currently no plans to reduce or expand this list; no necessity to. Could change if this system is used for another game, or if more party members are added, which they won't in this game. These values are all integers.
		max_health_points,
		current_health_points,
		max_effort_points,
		current_effort_points,
		attack,
		defense,
		speed,
		ingenuity,
		critical,
		level,
		experience,
	],
	"player_inventory" : {} # Dictionary, "item_location" : amount (int)
	"player_equipped" : [ # Array of Strings, which are the locations of each Item within the game's folder structure.
		weapon,
		armor_head,
		armor_chest,
		armor_special,
	]
	"location" : "", # Identifier for the location where the game was last saved. Currently unused. It's a String so that I can give each location an identifier to be used/loaded to here.
	# Any additions to this get placed here. Currently this is all I need to save/load.
}
'''

##Initializes save data from inputted code.
func initialize_from_input(
			slot_name:String,
			playtime:int,
			statistics:StatisticInstance,
			inventory:Dictionary = {},
			equipped:Array = [],
			location:String = "",
			):
	var new_data = {}
	new_data["save_version"] = "v1"
	new_data["slot_name"] = slot_name
	new_data["playtime"] = playtime
	new_data["player_statistics"] = [
			statistics.max_health_points,
			statistics.current_health_points,
			statistics.max_effort_points,
			statistics.current_effort_points,
			statistics.attack,
			statistics.defense,
			statistics.speed,
			statistics.ingenuity,
			statistics.critical,
			statistics.level,
			statistics.experience
			]
	new_data["player_inventory"] = inventory
	new_data["player_equipped"] = equipped
	new_data["location"] = location
	
	save_data = new_data

##Saves the save data to a file at a certain slot number.
func save_to_file(overwrite:bool = true):
	if !save_data.is_empty() && slot_number > 0:
		var save_location:String = "user://save_"+str(slot_number)+".sav"
		if FileAccess.file_exists(save_location):
			if overwrite:
				return -1 # Can't save!
			else:
				var file = FileAccess.open(save_location, FileAccess.WRITE)
				file.store_var(save_data)
		else:
			var file = FileAccess.open(save_location, FileAccess.WRITE)
			file.store_var(save_data)

##Loads save data from the file at a certain slot number.
func load_from_slot(slot:int):
	var filepath:String = "user://save_"+str(slot)+".sav"
	if FileAccess.file_exists(filepath):
		var file = FileAccess.open(filepath, FileAccess.READ)
		
		save_data = file.get_var()
	else:
		return -1 # Can't load!
