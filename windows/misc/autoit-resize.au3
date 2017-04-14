;http://stackoverflow.com/questions/23190825/autoit-detecting-window-screen-resolution-in-an-if-statement
local $myWidth1 = @DesktopWidth / 3;
local $myWidth2 = @DesktopWidth / 2;
local $myHeight1 = @DesktopHeight
local $myHeight2 = @DesktopHeight / 2
local $myDeltaWidth1 = 30
local $myDeltaWidth2 = @DesktopWidth / 9

;https://www.autoitscript.com/autoit3/docs/functions/Send.htm
;Ctrl-Alt
HotKeySet("^!{LEFT}", "MoveWindowLeft")
HotKeySet("^!{RIGHT}", "MoveWindowRight")
HotKeySet("^!c", "MoveWindowCenter")
HotKeySet("^!m", "MaximizeWindow")

HotKeySet("^!{UP}", "MoveWindowTop")
HotKeySet("^!{DOWN}", "MoveWindowBottom")


; make it bigger or smaller
HotKeySet("^!=", "MakeWindowBigger")
HotKeySet("^!-", "MakeWindowSmaller")

; 3 | 2
; 4 | 1
HotKeySet("^!1", "MoveWindowQ3")
HotKeySet("^!2", "MoveWindowQ2")
HotKeySet("^!3", "MoveWindowQ4")
HotKeySet("^!4", "MoveWindowQ1")


;holding
While 1
    Sleep(2000)
WEnd

Func GetActiveWindow()
   return WinGetTitle("[ACTIVE]")
EndFunc

Func MaximizeWindow()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, @DesktopWidth, @DesktopHeight)
EndFunc

Func MoveWindowLeft()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, $myWidth1, $myHeight1)
EndFunc


Func MoveWindowCenter()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth1 -5, 0, $myWidth1 + $myDeltaWidth1, $myHeight1)
EndFunc


Func MoveWindowRight()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", $myWidth1 * 2, 0, $myWidth1, $myHeight1)
EndFunc


Func MoveWindowTop()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, 0, @DesktopWidth, $myHeight2)
EndFunc

Func MoveWindowBottom()
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)
   WinMove($hWnd, "", 0, $myHeight2, @DesktopWidth, $myHeight2)
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


Func MakeWindowBigger()
   Local $aPos = WinGetPos("[ACTIVE]")
   Local $hWnd = GetActiveWindow()
   WinActivate($hWnd)

   local $newWidth = $aPos[2] + $myDeltaWidth2
   local $newLeft = $aPos[0]

   If $newWidth + $aPos[0] >= @DesktopWidth Then
	  $newLeft= $aPos[0] - $myDeltaWidth2
	  $newWidth = @DesktopWidth - $newLeft
   EndIf

   WinMove($hWnd, "", $newLeft, $aPos[1], $newWidth, $aPos[3])
EndFunc


Func MakeWindowSmaller()
   Local $aPos = WinGetPos("[ACTIVE]")
   Local $hWnd = GetActiveWindow()
   Local $minWidth = 400
   WinActivate($hWnd)

   local $newWidth = $aPos[2] - $myDeltaWidth2

   If $newWidth < $minWidth Then
	  $newWidth = $minWidth
   EndIf

   WinMove($hWnd, "", $aPos[0], $aPos[1], $newWidth, $aPos[3])
EndFunc
