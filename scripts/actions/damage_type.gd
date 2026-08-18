extends Resource
##Resource for defining types of damage. Has a name for the type of damage, as well as a description.
class_name DamageType

@export_placeholder("Fire") var type_name:String
@export_multiline("Description") var type_description:String
