## debugger.gd
class_name Debugger

## This function checks all exported properties of a Node to see if there are any unassigned in the editor.
## If there are unassigned properties, it will run into an error and pause the editor.
static func assert_all_exported_properties(node: Node) -> void:
	var property_list := (node.get_script() as Script).get_script_property_list()
	for property in property_list:
		if property.usage == 4102: #4102 is an exported property 
			var error_message := "Missing assignment of a property \"%s\" on node: \"%s\")"
			var property_value = node.get(property.name)
			assert(property_value != null, error_message % [property.name, str(node.get_path())])


## Example usage
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
