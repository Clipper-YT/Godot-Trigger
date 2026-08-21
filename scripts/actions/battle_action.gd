extends Resource
##An action for use in battle.
class_name BattleAction

##The name of this action.
@export var action_name:String
##The description of this action.
@export_multiline() var action_description:String
##Array of ActionEffects this action applies.
@export var effects:Array[ActionEffect]
