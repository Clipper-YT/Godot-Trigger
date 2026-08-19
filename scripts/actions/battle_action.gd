extends Resource
class_name BattleAction

@export var action_name:String
@export_multiline() var action_description:String
@export var effects:Array[ActionEffect]
