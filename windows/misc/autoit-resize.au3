;http://stackoverflow.com/questions/23190825/autoit-detecting-window-screen-resolution-in-an-if-statement
local $myWidth1 = @DesktopWidth / 3;
local $myWidth2 = @DesktopWidth / 2;
local $myHeight = @DesktopHeight

;https://www.autoitscript.com/autoit3/docs/functions/Send.htm
;Ctrl-Alt
HotKeySet("^!{LEFT}", "MoveWindowLeft") ;
HotKeySet("^!{RIGHT}", "MoveWindowRight") ;
HotKeySet("^!c", "MoveWindowCenter") ;

HotKeySet("^!1", "MoveWindowQ3") ;
HotKeySet("^!2", "MoveWindowQ2") ;
HotKeySet("^!3", "MoveWindowQ4") ;
HotKeySet("^!4", "MoveWindowQ1") ;


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
   WinMove($hWnd, "", 0, 0, $myWidth1, $myHeight)
EndFunc


Func MoveWindowCenter()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth1, 0, $myWidth1, $myHeight)
EndFunc


Func MoveWindowRight()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth1 * 2, 0, $myWidth1, $myHeight)
EndFunc


; 3 | 2
; 4 | 1
Func MoveWindowQ1()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", @DesktopWidth / 2, @DesktopHeight / 2, @DesktopWidth / 2, @DesktopHeight / 2)
EndFunc

Func MoveWindowQ2()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", @DesktopWidth / 2, 0, @DesktopWidth / 2, @DesktopHeight / 2)
EndFunc

Func MoveWindowQ3()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, @DesktopWidth / 2, @DesktopHeight / 2)
EndFunc

Func MoveWindowQ4()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, @DesktopHeight / 2, @DesktopWidth / 2, @DesktopHeight / 2)
EndFunc
