#Requires AutoHotkey v2.0
#Include "constants.ahk"
{
	MouseMove 115, 137, speed
	sleep gap
	click
	sleep gap
	MouseMove 131, 75, speed
	sleep gap
	click
	;Start one below to refresh
	MouseMove xvalue, yvalue + between, speed
	sleep gap
	click
	sleep 2 * longGap
	MouseMove xvalue, yvalue, speed	
	click
	sleep longGap
	click
	sleep gap
	MouseMove 0, 0, speed		
}