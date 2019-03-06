package require Tk

set about "minEd - a minimal editor

F1: help
F2: load
F3: save
"

pack [scrollbar .y -command ".t yview"] -side right -fill y
pack [text .t -wrap word -yscrollc ".y set" -undo 1] -side right -fill both -expand 1

bind . <F1> {tk_messageBox -message $about}
bind . <F2> {loadText .t [tk_getOpenFile]}
bind . <F3> {saveText .t [tk_getSaveFile]}

proc loadText {w fn} {
   if {$fn==""} return
   wm title . [file tail $fn]
   set fp [open $fn]
   $w delete 1.0 end
   $w insert end [read $fp]
   close $fp
}

proc saveText {w fn} {
   if {$fn==""} return
   set fp [open $fn w]
   puts -nonewline $fp [$w get 1.0 "end - 1 c"]
   close $fp
}

if {$argv != ""} {loadText .t [lindex $argv 0]}

