## utility_class.gd
class_name UtilityClass


## Returns all children of given type.
## The returned Array is untyped, so it has to be assigned to a typed array later - see example usage below.
static func get_children_of_type(parent: Node, type: Variant) -> Array:
	var array: Array
	for child: Node in parent.get_children():
		if is_instance_of(child, type):
			array.append(child)
	return array 


## Returns the first child of given type, will ignore the other children.
## The returned Node is untyped, so it has to be casted later - see example usage below.
static func get_child_of_type(parent: Node, type: Variant) -> Node:
	if parent == null:
		return null
	for child: Node in parent.get_children():
		if is_instance_of(child, type):
			return child
	return null


## Example usage
## Player.gd
class_name Player
func _ready() -> void:
	var typed_children: Array[Interactable]
	typed_children.assign(GlobalDebugger.get_children_of_type(self, Interactable))
	for child: Interactable in typed_children:
		child.interact()
  
	var first_child_of_type: Interactable = get_child_of_type(self, Interactable) as Interactable
	first_child_of_type.interact()


## Interactable.gd
class_name Interactable
func interact() -> void:
	pass
