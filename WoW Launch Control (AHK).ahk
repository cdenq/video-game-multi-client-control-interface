;-----------------------------------------------------------
; Auto-Execute Section
;-----------------------------------------------------------
;Start off
	Suspend, On
	SetScrollLockState, % A_ScrollLockState := "Off"
	
;Window Variables
	global MainBoxW := 1440
	global MainBoxH := 810
	global MainBoxX := 0
	global MainBoxY := 0
	global SubBoxW := 480
	global SubBoxH := 270
	global SubBoxY := 810
	global SubBoxX2 := SubBoxW * 0
	global SubBoxX3 := SubBoxW * 1
	global SubBoxX4 := SubBoxW * 2
	global SubBoxX5 := SubBoxW * 3
	global WindowFocus := "WoW1"

	global Password := ""
	
	global Account1 := ""
	global Account2 := ""
	global Account3 := ""
	global Account4 := ""
	global Account5 := ""
	
	global Account6 := ""
	global Account7 := ""
	global Account8 := ""
	global Account9 := ""
	global Account10 := ""
	
	global Account11 := ""
	global Account12 := ""
	global Account13 := ""
	global Account14 := ""
	global Account15 := ""
	
	global Account16 := ""
	global Account17 := ""
	global Account18 := ""
	global Account19 := ""
	global Account20 := ""
	
	global Account21 := ""
	global Account22 := ""
	global Account23 := ""
	global Account24 := ""
	global Account25 := ""

;Toggle on/off
	~ScrollLock::
	Suspend, % A_ScrollLockState == "On"
    SetScrollLockState, % A_ScrollLockState := {"On": "Off", "Off": "On"}[A_ScrollLockState]
	Return
;-----------------------------------------------------------
; Launch 5 instances
; SCROLLLOCK ON: ALT + CTRL + L
;-----------------------------------------------------------
^!l::
{
	LabelLaunch:
	LoopNumberLaunch := 2
	LoopAccount := 1
	;1 for cdenq1-5
	;6 for bdenq1-5
	;11 for mains
	;16 for sdenq1-5
	;21 for wdenq1-5

	;MainBox
	Run, D:\World of Warcraft\Wow.exe
	WinActivate, World of Warcraft
	WinWaitActive, World of Warcraft
	WinSetTitle, WoW1
	WinSet, Style, -0xC00000 ; hide title bar
	WinMove,,,%MainBoxX%, %MainBoxY%, %MainBoxW%, %MainBoxH%
		;Log-in
		Send, % Account%LoopAccount%
		Sleep, 100
		Send {Tab}
		Sleep, 100
		GoSub, ^!c
		LoopAccount++
	
	;SubBoxes
	Loop, 4 {
		Run, D:\World of Warcraft\Wow.exe
		WinActivate, World of Warcraft
		WinWaitActive, World of Warcraft
		WinSetTitle, WoW%LoopNumberLaunch%
		WinSet, Style, -0xC00000 ; hide title bar
		WinMove,,,% SubBoxX%LoopNumberLaunch%, %SubBoxY%, %SubBoxW%, %SubBoxH%
			;Log-in
			Send, % Account%LoopAccount%
			Sleep, 100
			Send {Tab}
			Sleep, 100
			GoSub, ^!c
			LoopAccount++
		LoopNumberLaunch++
	}
	WinActivate, WoW1
}
Return

;-----------------------------------------------------------
; Login Subroutine
;-----------------------------------------------------------
^!k::
{
	LabelLogIn:
	LoopWoWs := 1
	LoopAccount := 1
	;1 for cdenq1-5
	;6 for bdenq1-5
	;11 for mains
	;16 for sdenq1-5
	;21 for wdenq1-5
	
	; type in account name + password
	Loop, 5 {
		WinActivate, WoW%LoopWoWs%
		WinWaitActive, WoW%LoopWoWs%
		Send, % Account%LoopAccount%
		Sleep, 100
		Send {Tab}
		Sleep, 100
		GoSub, ^!c
		LoopWoWs++
		LoopAccount++
	}
}
Return

;-----------------------------------------------------------
; Password Subroutine
; SCROLLLOCK ON: ALT + CTRL + C
;-----------------------------------------------------------
^!c::
{
	LabelPassword:
	Send, {raw}%Password%
	Sleep, 100
	Send {Enter}
}
Return

;-----------------------------------------------------------
; Window Name Tag
; SCROLLLOCK ON: ALT + CTRL + T
;-----------------------------------------------------------
^!t::
{
	;FOCUS/CLICK ACTIVE THE WINDOW YOU WANT TO RENAME
	WinGetActiveTitle, Title
	Sleep, 100
	WinSetTitle, %Title%,,WoWControl
	Sleep, 100
}
Return

;-----------------------------------------------------------
; Window Name Reset
; SCROLLLOCK ON: ALT + CTRL + R
;-----------------------------------------------------------
^!r::
{
	;FOCUS/CLICK ACTIVE THE WINDOW YOU WANT TO RENAME
	WinGetActiveTitle, Title
	Sleep, 100
	WinSetTitle, %Title%,,World of Warcraft
	Sleep, 100
}
Return

;-----------------------------------------------------------
; Close 5 instaces
; SCROLLLOCK ON: ALT + CTRL + X
;-----------------------------------------------------------
^!x::
{
	LabelKill:
	LoopWoWs := 1

	;Kill Script
	Loop, 5 {
		WinKill, WoW%LoopWoWs%
		LoopWoWs++
	}
}
Return

;-----------------------------------------------------------
; Resize 5 instances
; SCROLLLOCK ON: ALT + CTRL + 1-5
;-----------------------------------------------------------
^!1::
^!2::
^!3::
^!4::
^!5::
{
	LabelResize:
	key := SubStr(A_ThisHotkey, 3)
	LoopWoWs := 1
	LoopNumberLaunch := 2
	
	; Setting Main
	WinActivate, WoW%key%
	WinWaitActive, WoW%key%
	WindowFocus = WoW%key%
	MsgBox, %WindowFocus%
	WinMove,,,%MainBoxX%, %MainBoxY%, %MainBoxW%, %MainBoxH%
		
	; Setting Subs
	Loop, 5 {
		If (LoopWoWs = key) {
			LoopWoWs++
		} else {
			WinActivate, WoW%LoopWoWs%
			WinWaitActive, WoW%LoopWoWs%
			WinMove,,,% SubBoxX%LoopNumberLaunch%, %SubBoxY%, %SubBoxW%, %SubBoxH%
			LoopWoWs++
			LoopNumberLaunch++
		}
	}
	WinActivate, WoW%key%
}
Return

;-----------------------------------------------------------
; Keyclone SubFunction: Single Keys (No Modifier)
;-----------------------------------------------------------
BroadcastSingleKey(hotKey)
{
	LoopWoWs := 1
	convertedKey := subStr(hotKey, 2)
	Loop, 5 {
		IfWinNotActive, WoW%LoopWoWs%
		ControlSend,, {%convertedKey%}, WoW%LoopWoWs%
		LoopWoWs++
	}
}
Return

;-----------------------------------------------------------
; Keyclone SubFunction: Movement Keys
;-----------------------------------------------------------
BroadcastMovementKey(hotKey)
{
	LoopWoWs := 1
	convertedKey := subStr(hotKey, 2)
	If RegExMatch(convertedKey, "UP") {
		convertedKey = %convertedKey%
	} else {
		convertedKey = %convertedKey% Down
	}
	
	Loop, 5 {
		IfWinNotActive, WoW%LoopWoWs%
		ControlSend,, {%convertedKey%}, WoW%LoopWoWs%
		LoopWoWs++
	}
}
Return

;-----------------------------------------------------------
; Mouse Broadcast SubFunction WIP
;-----------------------------------------------------------
BroadcastMouse(mouseKey)
{
	;LoopWoWs := 1
	;WinGetTitle, thisWindow, A
	;CoordMode, Mouse, Client
	;MouseGetPos, xCoordinate, yCoordinate
	;xCoordinateSub := round(xCoordinate / 3)
	;yCoordinateSub := round(yCoordinate / 3)
	;xCoordinateMain := round(xCoordinate * 3)
	;yCoordinateMain := round(yCoordinate * 3)
	;
	;If InStr(mouseKey, "~XButton1") {
	;	mouseKey = X1
	;} else if InStr(mouseKey, "~LButton") {
	;	mouseKey = LEFT
	;} else if InStr(mouseKey, "~RButton") {
	;	mouseKey = RIGHT
	;} else if InStr(mouseKey, "~MButton") {
	;	mouseKey = MIDDLE
	;} else if InStr(mouseKey, "~XButton2") {
	;	mouseKey = X2
	;} else {
	;	MsgBox, Unidentified mouse click!
	;}
	;
	;IfWinActive, %WindowFocus% {
	;	;WinActivate, %thisWindow%
	;	;WinWaitActive, %thisWindow%
	;	MouseMove, %xCoordinate%, %yCoordinate%
	;	MouseClick, %mouseKey%, %xCoordinate%, %yCoordinate%
	;	Loop, 5 {
	;		WinActivate, WoW%LoopWoWs%,, %thisWindow%
	;		WinWaitActive, WoW%LoopWoWs%
	;		MouseMove, %xCoordinateSub%, %yCoordinateSub%
	;		Sleep, 25
	;		MouseClick, %mouseKey%, %xCoordinateSub%, %yCoordinateSub%
	;		Sleep, 25
	;		LoopWoWs++
	;	}
	;} else {
	;	MouseMove, %xCoordinate%, %yCoordinate%
	;	MouseClick, %mouseKey%, %xCoordinate%, %yCoordinate%
	;	Loop, 5 {
	;		WinActivate, WoW%LoopWoWs%,, %thisWindow%
	;		WinWaitActive, WoW%LoopWoWs%
	;		MouseMove, %xCoordinateSub%, %yCoordinateSub%
	;		Sleep, 25
	;		MouseClick, %mouseKey%, %xCoordinateSub%, %yCoordinateSub%
	;		Sleep, 25
	;		LoopWoWs++
	;	}
	;}
	;		
	;WinActivate, WoW%LoopWoWs%
	;	WinWaitActive, WoW%LoopWoWs%
	;	Sleep, 1000
	;	
	;	; USING MOUSE MOVE AND CLIC KINSTEAD
	;	; ControlClick, Edit1,WoW%LoopWoWs%,,%mouseKey%,,x%xCoordinatePass% y%yCoordinatePass%
	;	SoundBeep, 1500
	;	LoopWoWs++
	;}
	;WinActivate, %thisWindow%
	;MouseMove, %xCoordinate%, %yCoordinate%
}
Return

;-----------------------------------------------------------
; Push Raw
;-----------------------------------------------------------
; Combat Hotbar
	~1::
	~2::
	~3::
	~4::
	~5::
	~6::
	~7::
	~8::
	~9::
	~0::
	~-::
	~=::
	
; Built-in Game UI Bindings
	~i::
	~p::
	~l::
	~c::
	~n::
	
; Built-in Game Roleplay Bindings
	~z::
	~x::
	~Space::

; Custom Bindings (need to be assigned in-game, used for multiboxing)
	~f::
	~g::
	~j::
	~k::
	~,::
	~.::
	BroadcastSingleKey(A_ThisHotkey)
	Return

; All Movement
	~Up::
	~Up UP::
	~Down::
	~Down UP::
	~Left::
	~Left UP::
	~Right::
	~Right UP::
	BroadcastMovementKey(A_ThisHotkey)
	Return
	
; Special Built-In Game Keys
	~Enter::
	~Escape::
		If (GetKeyState("``", "P")) {
			BroadcastSingleKey(A_ThisHotkey)
		}
		Return

;-----------------------------------------------------------
; Push SHIFT + 0-9 WIP
;-----------------------------------------------------------
;~+1::BroadcastKey("{Shift down}{1 down}{1 up}{Shift up}")
;~+2::BroadcastKey("{Shift down}{2 down}{2 up}{Shift up}")
;~+3::BroadcastKey("{Shift down}{3 down}{3 up}{Shift up}")
;~+4::BroadcastKey("{Shift down}{4 down}{4 up}{Shift up}")
;~+5::BroadcastKey("{Shift down}{5 down}{5 up}{Shift up}")
;~+6::BroadcastKey("{Shift down}{6 down}{6 up}{Shift up}")
;~+7::BroadcastKey("{Shift down}{7 down}{7 up}{Shift up}")
;~+8::BroadcastKey("{Shift down}{8 down}{8 up}{Shift up}")
;~+9::BroadcastKey("{Shift down}{9 down}{9 up}{Shift up}")
;~+0::BroadcastKey("{Shift down}{0 down}{0 up}{Shift up}")
;~+-::BroadcastKey("{Shift down}{- down}{- up}{Shift up}")
;~+=::BroadcastKey("{Shift down}{= down}{= up}{Shift up}")

;-----------------------------------------------------------i
; Push CTRL + 0-9 WIP
;-----------------------------------------------------------
;~^1::BroadcastKey("{Ctrl down}{1 down}{1 up}{Ctrl up}")
;~^2::BroadcastKey("{Ctrl down}{2 down}{2 up}{Ctrl up}")
;~^3::BroadcastKey("{Ctrl down}{3 down}{3 up}{Ctrl up}")
;~^4::BroadcastKey("{Ctrl down}{4 down}{4 up}{Ctrl up}")
;~^5::BroadcastKey("{Ctrl down}{5 down}{5 up}{Ctrl up}")
;~^6::BroadcastKey("{Ctrl down}{6 down}{6 up}{Ctrl up}")
;~^7::BroadcastKey("{Ctrl down}{7 down}{7 up}{Ctrl up}")
;~^8::BroadcastKey("{Ctrl down}{8 down}{8 up}{Ctrl up}")
;~^9::BroadcastKey("{Ctrl down}{9 down}{9 up}{Ctrl up}")
;~^0::BroadcastKey("{Ctrl down}{0 down}{0 up}{Ctrl up}")
;~^-::BroadcastKey("{Ctrl down}{- down}{- up}{Ctrl up}")
;~^=::BroadcastKey("{Ctrl down}{= down}{= up}{Ctrl up}")

;-----------------------------------------------------------
; Mouse Broadcasting WIP
;-----------------------------------------------------------
~LButton::
~RButton::
~MButton::
~XButton1::
~XButton2::
	;If (GetKeyState("``", "P")) {
	;	KeyWait, ``
	;	BroadcastMouse(A_ThisHotkey)
	;	Sleep, 100
	;}
	Return

;------------------------------------
; Script Functions
;------------------------------------
	^F6::
	{
		Loop, 900 {
			;ControlSend,, {f}, WoWControl
			;ControlSend,, {1}, WoWControl
			While GetKeyState("r" , "p") {
				ControlSend,, {j}, WoWControl
				Sleep, 100
			} 
			While GetKeyState("t" , "p") {
				ControlSend,, {k}, WoWControl
				Sleep, 100
			}
			ControlSend,, {Numpad1}, WoWControl
			ControlSend,, {3}, WoWControl
			ControlSend,, {5}, WoWControl
			ControlSend,, {2}, WoWControl
			;ControlSend,, {8}, WoWControl
			;ControlSend,, {3}, WoWControl
			;ControlSend,, {Shift down}4{Shift up}, WoWControl
			;ControlSend,, {Shift down}2{Shift up}, WoWControl
			;ControlSend,, {7}, WoWControl
			Sleep, 550
		}
	}
	Return
	^F7::
	{
		; Disenchanting
		Loop, 100 {
			Click
			;ControlClick, x205 y90, WoWControl,,,, Pos
			;Msgbox, 2 TEST
			;Send {1}
			;Sleep, 3600 ;disenchant
			;Sleep, 4350 ;gun/bow shoot
			Sleep, 250 ;auction sell
			
		}
	}
	Return
	^F8::
	{
		; REQUIRES FULL SCREEN
		variableLoop := 0
		Loop, 30 {			
			; Presses - hotkey, which is commendation
			Loop, 5 {
				Send {-}
				Sleep, 2350
			}
		
		If (variableLoop>10) {
			Click, 59 524 Right ;RED
			;Click, 69 462 Right ;BLUE
			;Click, 271 341 Right ;PURPLE
			;Click, 277 399 Right ;GREEN
			;Click, 57 398 Right ;ORANGE
		} else {
			Click, 59 524 Right ;RED
			;Click, 69 462 Right ;BLUE
			;Click, 271 341 Right ;PURPLE
			;Click, 277 399 Right ;GREEN
			;Click, 57 398 Right ;ORANGE
		}
			
		Sleep, 500
		Click, 891 339
		variableLoop++
		}
	}
	Return
	^F9::
	{
		MouseGetPos, xx, yy
		pixelGetColor, colorCheckFree, %xx%, %yy%, RGB
		MsgBox, %xx%, %yy%, %colorCheckFree%
		clipboard = %xx%, %yy%, %colorCheckFree%
	}
	Return
	^F10::Pause
	^F11::Reload
	^F12::ExitApp
