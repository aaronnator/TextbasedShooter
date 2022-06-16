extends Node

# check out text parsers btw, "infocom"
# this is going to be simple

func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "error: no words parsed."
		
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
		
	match first_word: #match is basically a switch-case type deal.
		"go":
			return go(second_word)
		"help":
			return help()
			
		_:
			return "Unrecognized command - try again."

func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"

	return "You go %s" % second_word
	
func help() -> String:
	return "You can use these commands: go [location], help"


#func connect
