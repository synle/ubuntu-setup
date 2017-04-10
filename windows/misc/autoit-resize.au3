;http://stackoverflow.com/questions/23190825/autoit-detecting-window-screen-resolution-in-an-if-statement
local $myWidth = @DesktopWidth / 3
local $myHeight = @DesktopHeight

;https://www.autoitscript.com/autoit3/docs/functions/Send.htm
;Ctrl-Alt
HotKeySet("^!{LEFT}", "MoveWindowLeft") ;
HotKeySet("^!{RIGHT}", "MoveWindowRight") ;
HotKeySet("^!c", "MoveWindowCenter") ;


;holding
While 1
    Sleep(1000)
WEnd

Func GetActiveWindow()
   return WinGetTitle("[ACTIVE]")
EndFunc

Func MoveWindowLeft()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, $myWidth, $myHeight)
EndFunc


Func MoveWindowCenter()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth, 0, $myWidth, $myHeight)
EndFunc


Func MoveWindowRight()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc


; 3 | 2
; 4 | 1
Func MoveWindowQ1()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc

Func MoveWindowQ2()
   WinActivate
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc

Func MoveWindowQ3()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc

Func MoveWindowQ4()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth * 2, 0, $myWidth, $myHeight)
EndFunc
