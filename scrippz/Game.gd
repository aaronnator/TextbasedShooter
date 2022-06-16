extends Control

const Response = preload("res://scenes/Response.tscn")
#summoning inputresponse at launch. this is from textadventure #3.
const InputResponse = preload("res://scenes/InputResponse.tscn")
export (int) var max_lines_remembered := 30 #this pushes the variable to the editor property page. instances are tracked separately.

var max_scroll_length := 0

onready var command_processor = $CommandProcessor
#telling godot where InputResponse goes. "onready" is called right before whenever "_ready()" would be called.
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
#you'll need to change that path as long as often as the actual nodes are changed
#apparently there are options to making it more dynamic
onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar() #getvscrollbar being a 


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value #all this scrollbar bs is from episode 4. v convoluted.
	var starting_message = Response.instance()
	starting_message.text = "You find yourself cornered by a pack of street Mormons." 
	add_response_to_game(starting_message)
	var extra_message = Response.instance()
	extra_message.text = "\t \t How do you wish to assert dominance?" 
	add_response_to_game(extra_message)	
	
	#TODO: improve starting message

func handle_scrollbar_changed(): #don't fuckin touch this garbage. it's about keeping the scrollbar down.
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


#interpret ".._entered" literally. like, the "enter" button.
func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return #prevent user from typing empty lines. yeet.
	
	var input_response = InputResponse.instance() #making the actual instance of the scene
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text,response) #this line works because of the inputresponse preload above
	add_response_to_game(input_response)

func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()

func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget): #kinda confused on whats goin down here but it's ep. 5 
			history_rows.get_child(i).queue_free() #queue free frees memory better than free().
