extends Resource
##Base class for modifiers that certain items can have.
class_name ItemModifier

##The name of this modifier. Appears in certain menus.
@export_placeholder("Modifier Name") var modifier_name:String
##The description of the effect of this modifier. Appears in certain menus.
@export_multiline("Modifier Description") var modifier_description:String
