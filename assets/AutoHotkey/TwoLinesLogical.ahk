#Requires AutoHotkey v2.0

#o::
{
	; Start of Id section
	send  "^{Home}"
	/* HERE IS THE NUMBER OF CHARACTERS FOR THE ID NUMBER */
	Loop 7 {
		send "+{Right}"
	}
	send "^x"
	send "{Delete}"
	send "^{End}"
	Loop 2 {
		send "{Enter}"
	}
	SendText '{'
	send "{Enter}"
	send "{Tab}"
	sendText '"Id": "'
	send "^v"
	sendText '",'
	; This is the end of Id section, begin Q
	send  "^{Home}"
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 6 {
		send "{Down}"
	}
	send "{Enter}"	
	sendText '"Q": "'
	send "^v"
	send  "^{Home}"
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 6 {
		send "{Down}"
	}
	sendText ' '
	send "^v"
	sendText '",'
	; end of Q and begin Answer
	send  "^{Home}"
	Loop 6 {
		send "+{Right}"
	}	
	send "^x"
	Loop 2 {
		send "{Delete}"
	}	
	Loop 6 {
		send "{Down}"
	}	
	send "{Enter}"
	sendText '"'
	send "^v"
	sendText '": '
	send  "^{Home}"
	send "+{End}"
	send "^x"
	Loop 2 {
		send "{Delete}"
	}
	send "^{End}"
	sendText '"'
	send "^v"
	sendText '",'
	send "{Enter}"
	sendText '"Type": "Logic"'	
	send "{Enter}"
	send "+{Tab}"
	SendText '},'
	send  "^{Home}"
	send "^+{End}"
	Loop 2 {
		send "{Tab}"
	}
	send "^c"	
	
	
}

