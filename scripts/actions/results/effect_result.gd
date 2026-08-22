extends RefCounted
##The results of an effect, stored in handy data format!
class_name EffectResult

##The user of the effect.
var user:CharacterInstance
##The targets of the effect.
var targets:Array[CharacterResult]

##If the action is a spell.
var is_spell:bool

##An additional debug message for the console output.
var additional_debug_message:String
