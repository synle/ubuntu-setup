;http://stackoverflow.com/questions/23190825/autoit-detecting-window-screen-resolution-in-an-if-statement
local $myWidth = @DesktopWidth / 3
local $myHeight = @DesktopHeight

;https://www.autoitscript.com/autoit3/docs/functions/Send.htm
;Ctrl-Alt
HotKeySet("^!{LEFT}", "MoveLeft") ;
HotKeySet("^!{RIGHT}", "MoveRight") ;
HotKeySet("^!c", "MoveCenter") ;

While 1
    Sleep(1000)
WEnd

Func MoveLeft()
  	Local $hWnd = GetActiveWindow()
    MoveWindowLeft($hWnd)
EndFunc

Func MoveCenter()
	Local $hWnd = GetActiveWindow()
	MoveWindowCenter($hWnd)
EndFunc


Func MoveRight()
	Local $hWnd = GetActiveWindow()
	MoveWindowRight($hWnd)
EndFunc



Func GetActiveWindow()
   return WinGetTitle("[ACTIVE]")
EndFunc

Func MoveWindowLeft($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, $myWidth, $myHeight)
EndFunc


Func MoveWindowCenter($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth, 0, $myWidth, $myHeight)
EndFunc


Func MoveWindowRight($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc


; 3 | 2
; 4 | 1
Func MoveWindowQ1($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc

Func MoveWindowQ2($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc

Func MoveWindowQ3($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc

Func MoveWindowQ4($hWnd)
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc
