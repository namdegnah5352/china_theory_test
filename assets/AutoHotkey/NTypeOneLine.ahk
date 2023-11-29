#Requires AutoHotkey v2.0

#n::
{
	; Start of Id section
	send  "^{Home}"
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
	Loop 2 {
		send "{Enter}"
	}
	send "{Tab}"
	sendText '"Id": "'
	send "^v"
	sendText '",'
	; This is the end of Id section, begin Q
	send  "^{Home}"
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 7 {
		send "{Down}"
	}	
	send "{Tab}"
	sendText '"Q": "'
	send "^v"
	sendText '",'
	; end of Q and begin A
	send  "^{Home}"
	Loop 3 {
		send "{Delete}"
	}
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 9 {
		send "{Down}"
	}
	send "{Enter}"	
	sendText '"A": "'
	send "^v"
	sendText '",'	
	; end of A and begin B
	send  "^{Home}"
	Loop 3 {
		send "{Delete}"
	}
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 8 {
		send "{Down}"
	}
	send "{Enter}"	
	sendText '"B": "'
	send "^v"
	sendText '",'	
	; end of B and begin C
	send  "^{Home}"
	Loop 3 {
		send "{Delete}"
	}
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 8 {
		send "{Down}"
	}
	send "{Enter}"	
	sendText '"C": "'
	send "^v"
	sendText '",'
	; end of C and begin D
	send  "^{Home}"
	Loop 3 {
		send "{Delete}"
	}
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 8 {
		send "{Down}"
	}
	send "{Enter}"	
	sendText '"D": "'
	send "^v"
	sendText '",'
	; end of D and begin Answer
	send  "^{Home}"	
	Loop 8 {
		send "{Delete}"
	}	
	send "+{End}"
	send "^x"
	send "{Delete}"
	Loop 8 {
		send "{Down}"
	}	
	send "{Enter}"	
	sendText '"Answer": "'
	send "^v"
	sendText '",'	
	; end of Answer and begin Type
	send "{Enter}"
	sendText '"Type": "N"'
	; end of Type and begin finish off
	send "{Enter}"
	send "+{Tab}"		
	SendText '},'
	send  "^{Home}"
	send "{Delete}"
	send "^+{End}"
	Loop 2 {
		send "{Tab}"
	}
	send "^c"
}

