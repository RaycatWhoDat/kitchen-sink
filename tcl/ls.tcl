#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}

foreach file [lsort -increasing [glob *]] {
    puts "$file"
}

