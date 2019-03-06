package require Tk

wm title . "Habit Tracker"
grid [ttk::frame .base -padding "3 3 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [label .base.hello1 -text "Hello!"] -column 1 -row 2 -sticky w
grid [label .base.hello2 -text "Hello!"] -column 2 -row 2 -sticky w
grid [label .base.hello3 -text "Hello!"] -column 3 -row 2 -sticky w

foreach w [winfo children .base] {grid configure $w -padx 5 -pady 5}

# Local Variables:
# compile-command: "tclsh ./tk-testing.tcl"
# End: 
