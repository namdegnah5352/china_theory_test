#Requires AutoHotkey v2.0


#q::
{
	gap := 100
	longGap := 1000
	speed := 50
	;click reduce to small screen, wait
	MouseMove 1872, 1051, speed
	sleep longGap
	click
	sleep longGap	
	;click 'go back' wait click again
	MouseMove 1829, 66, speed
	sleep longGap
	click
	sleep longGap
	click
	sleep longGap
	;wait, click 'live tv', wait
	MouseMove 393, 527, speed
	click
	sleep longGap
	;go back to sky sports
	MouseMove 487, 1000, speed
	;wait, run Wheeldown, wait
	sleep longGap
	Loop (1)
	{
		Send "{Wheeldown}"
		sleep gap	
	}		
	;wait, click 'tnt sports, wait
	sleep longGap
	click 
	;TNI sports is the first one so no need to move or click
}

