#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}

variable port 8090

proc send_to_socket {sock} {
    if { [eof $sock] || [catch {gets $sock line}] } {
        puts "Closing $sock."
        close $sock
    }

    if { [info exists line] && $line != "" } {
        puts "From socket: $line"
        catch { puts $sock "From server: Message received!" }
    } 
}

proc accept_connection {sock addr port} {
    puts "$sock $addr $port"
    fconfigure $sock -buffering line
    fileevent $sock readable [list send_to_socket $sock]
}

set s [socket -server accept_connection $port]
puts "Now running on port $port."
vwait forever
