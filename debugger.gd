## debugger.gd
class_name Debugger

## This function checks all exported properties of a Node to see if there are any unassigned in the editor.
## If there are unassigned properties, it will run into an error and pause the editor.
static func assert_all_exported_properties(node: Node) -> void:
	var script: Script = node.get_script()
	var property_list: Array[Dictionary] = script.get_script_property_list()
	for property: Dictionary in property_list:
		if property.usage == 4102: #4102 is an exported property 
			var error_message: String = "-\"%s\"- property on node: -\"%s\"- is missing assignment"
			var property_name: String = property.name
			var property_value: Variant = node.get(property_name)
			assert(property_value != null, error_message % [property.name, str(node.get_path())])


## some_class.gd
class_name SomeClass

@export var exported_property_node: Node
@export var exported_property_packed_scene: PackedScene
@export var exported_property_bool: bool
var not_exported_property_node: Node
var not_exported_property_packed_scene: PackedScene
var not_exported_property_bool: bool

func _ready() -> void:
	## This call will check the 3 exported properties of type: Node, PackedScene and bool.
	## If the Node or PackedScene properties have not been assigned in the editor, it will run into an error and pause the editor.
	Debugger.assert_all_exported_properties(self)
