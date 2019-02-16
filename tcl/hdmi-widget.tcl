# -*- mode: Tcl; compile-command: "./hdmi-widget.tcl" -*-

#!/bin/sh
# Start `wish`. \
    exec wish "$0" "$@"

namespace eval HdmiWidget {
    namespace eval vars {
        variable connectedPatten {.*\sconnected}
        variable disconnectedPatten {.*\sdisconnected}
        variable displays [exec xrandr]
        variable connectedDisplays [regexp -all -inline -line {.*\sconnected} $displays]
        variable xrandrCommand [list xrandr --output]
    }

    proc connectHdmi {device direction} {
        if {$device == ""} {
            puts "No device specified."
            return
        } else {
            lappend vars::xrandrCommand $device --auto
        }

        # If the direction exists...
        if {$direction == "left" || $direction == "right"} {
            lappend vars::xrandrCommand --$direction-of eDP-1
        } elseif {$direction != ""} {
            lappend vars::xrandrCommand --$direction eDP-1
        }

        exec {*}$vars::xrandrCommand
    }

    proc disconnectHdmi {device} {
        if {$device == ""} {
            puts "No device specified."
            return
        }

        exec {*}[list xrandr --output $device --off]
    }

    proc drawWidget {} {
        foreach match $vars::connectedDisplays {
            regexp {(.*)\s} $match -> device
            if {[regexp {HDMI} $device]} {
                label .connect-text -foreground black -pady 20 -text "Connect HDMI"
                button .mirror-button -text "Mirror" -command [list HdmiWidget::connectHdmi $device ""]
                
                button .connect-right-button -text "Right" -command [list HdmiWidget::connectHdmi $device "right"]
                button .connect-left-button -text "Left" -command [list HdmiWidget::connectHdmi $device "left"]
                button .connect-above-button -text "Above" -command [list HdmiWidget::connectHdmi $device "above"]
                button .connect-below-button -text "Below" -command [list HdmiWidget::connectHdmi $device "below"]

                label .disconnect-text -foreground black -pady 20 -text "Disconnect HDMI"
                button .disconnect-button -text "Disconnect HDMI" -command [list HdmiWidget::disconnectHdmi $device]

                
                pack .connect-text .mirror-button .connect-right-button .connect-left-button .connect-above-button .connect-below-button .disconnect-text .disconnect-button
            }
        }

        label .exit-text -foreground black -pady 20 -text "Exit"
        button .exit-button -text "Exit" -command { exit }
        pack .exit-text .exit-button
    }
}

HdmiWidget::drawWidget
