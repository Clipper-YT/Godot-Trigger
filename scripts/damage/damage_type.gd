extends Resource
##Resource for defining types of damage. Has a name for the type of damage, as well as a description.
class_name DamageType

##The name of this damage type.
@export_placeholder("Fire") var type_name:String
##The description for this damage type.
@export_multiline("Description") var type_description:String
