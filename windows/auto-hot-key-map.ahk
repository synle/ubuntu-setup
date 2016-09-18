; https://www.autohotkey.com/download/
; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN

; Switches the left Control and Alt keys.
LCtrl::Alt
LAlt::Ctrl

; ctrl + q to quit
^q::Send !{F4}

; ctrl shift 4 to take screen shot
^+4::SendInput {PrintScreen}


; alt c to terminate command
!c::Send ^{c}

;win ctrl left to resize
#^Left::Send #{Left}
#^Right::Send #{Right}
#^m::Send #{Up}


; switch between mouse speed
;http://www.howtogeek.com/howto/45366/how-to-set-different-speeds-for-your-trackpad-and-external-mouse/
#F1::DllCall("SystemParametersInfo", Int,113, Int,0, UInt,14, Int,2) ;normal sensisivity
#F2::DllCall("SystemParametersInfo", Int,113, Int,0, UInt,6, Int,2) ;low sensitivity
#F3::DllCall("SystemParametersInfo", Int,113, Int,0, UInt,20, Int,2) ;high sensitivity
