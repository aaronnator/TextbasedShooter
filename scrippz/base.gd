extends Node
#i guess this is how u import???
const DefaultManager = preload("res://scrippz/guiTesting.gd")
onready var default_manager = DefaultManager.new()


#var actual_string = functioncall() %s 

var flow : Array = [
	["You are in a room",
		[
			[1,"Look around"]
		]
	
	],
	["You notice a bed, desk, and door",
		[
			[2,"Examine the bed"],
			[3,"Approach the door"],
			[4,"Approach desk"]
		]
	]
]

func _ready() -> void:
	pass

func move_to_index(index: int) -> void:
	var action_number : int = 1
	print("")
	print(flow[index][0])
	for actino in flow[index][1]:
		print(str(action_number) + ". " + action[1])
		action_number += 1
	#current_index = index
	
