;http://stackoverflow.com/questions/23190825/autoit-detecting-window-screen-resolution-in-an-if-statement
local $myWidth1 = @DesktopWidth / 3;
local $myWidth2 = @DesktopWidth / 2;
local $myHeight1 = @DesktopHeight
local $myHeight2 = @DesktopHeight / 2
local $myDeltaWidth1 = 30

;https://www.autoitscript.com/autoit3/docs/functions/Send.htm
;Ctrl-Alt
HotKeySet("^!{LEFT}", "MoveWindowLeft") ;
HotKeySet("^!{RIGHT}", "MoveWindowRight") ;
HotKeySet("^!c", "MoveWindowCenter") ;


; 3 | 2
; 4 | 1
HotKeySet("^!1", "MoveWindowQ3") ;
HotKeySet("^!2", "MoveWindowQ2") ;
HotKeySet("^!3", "MoveWindowQ4") ;
HotKeySet("^!4", "MoveWindowQ1") ;


;holding
While 1
    Sleep(2000)
WEnd

Func GetActiveWindow()
   return WinGetTitle("[ACTIVE]")
EndFunc

Func MoveWindowLeft()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, $myWidth1, $myHeight1)
EndFunc


Func MoveWindowCenter()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth1 - $myDeltaWidth1, 0, $myWidth1 + $myDeltaWidth1, $myHeight1)
EndFunc


Func MoveWindowRight()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth1 * 2, 0, $myWidth1, $myHeight1)
EndFunc


; 3 | 2
; 4 | 1
Func MoveWindowQ1()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth2, $myHeight2, $myWidth2, $myHeight2)
EndFunc

Func MoveWindowQ2()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth2, 0, $myWidth2, $myHeight2)
EndFunc

Func MoveWindowQ3()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, $myWidth2, $myHeight2)
EndFunc

Func MoveWindowQ4()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, $myHeight2, $myWidth2, $myHeight2)
EndFunc
