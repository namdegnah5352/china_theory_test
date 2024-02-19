#Requires AutoHotkey v2.0


#q::
{
	gap := 100
	longGap := 1000
	speed := 50
	extremeGap := 3500
	;click reduce to small screen, wait
	MouseMove 822, 361, speed
	sleep longGap
	click
	sleep longGap	
}