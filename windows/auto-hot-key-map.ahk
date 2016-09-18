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
