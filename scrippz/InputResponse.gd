extends VBoxContainer

#onready var response = $Response somewhat slow way to access


#this way is slower but saves more memory
func set_text(input: String, response: String):  # <--- static types are used here
	$InputHistory.text = " > " + input # btw we can see that we used dollar sign and script context to access child nodes
	$Response.text = response 
