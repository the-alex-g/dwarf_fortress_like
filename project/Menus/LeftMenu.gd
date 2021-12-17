extends TabContainer

# signals
signal item_selected(item_name)

# enums

# constants
const BUILDING_NAMES := [
	"CARPENTER",
	"JEWELER",
	"STONEWORKER",
	"SMELTER",
	"STATUE",
	"BED",
	"WALL",
	"ROAD",
	"DOOR",
]

const RESOURCE_NAMES := [
	"WOOD",
	"STONE",
	"GEMS",
	"FOOD",
	"GLASS",
	"IRON",
	"IRON ORE",
	"GOLD",
	"GOLD ORE",
	"SILVER",
	"SILVER ORE",
]

# exported variables

# variables
var _ignore
var _resource_name_to_item := {}
var _building_name_to_item := {}

# onready variables
onready var _building_tree := $Build/Tree
onready var _resource_tree := $Resources/Tree

func _ready()->void:
	var build_root:TreeItem = _building_tree.create_item()
	for n in BUILDING_NAMES:
		var new_item:TreeItem = _building_tree.create_item(build_root)
		new_item.set_text(0, n.capitalize())
		new_item.set_text(1, "0")
		_building_name_to_item[n] = new_item
	var resource_root:TreeItem = _resource_tree.create_item()
	for n in RESOURCE_NAMES:
		var new_item:TreeItem = _resource_tree.create_item(resource_root)
		new_item.set_text(0, n.capitalize())
		new_item.set_text(1, "0")
		_resource_name_to_item[n] = new_item
	_new_building("STATUE")


func _new_building(building_name:String)->void:
	var item:TreeItem = _building_name_to_item[building_name.to_upper()]
	var current_number_as_string := item.get_text(1)
	var current_number := int(current_number_as_string)
	current_number += 1
	item.set_text(1, str(current_number))


func _update_resource(resource_name:String, subtract := false):
	var item:TreeItem = _resource_name_to_item[resource_name.to_upper()]
	var current_number_as_string := item.get_text(1)
	var current_number := int(current_number_as_string)
	current_number += -1 if subtract else 1
	item.set_text(1, str(current_number))


func _on_build_tree_item_selected()->void:
	var mouse_position := get_global_mouse_position()
	var selected_item:TreeItem = _building_tree.get_item_at_position(mouse_position)
	emit_signal("item_selected", selected_item.get_text(0))
