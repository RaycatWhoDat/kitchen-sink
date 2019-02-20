#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}

proc list_files directory {
    set excluded_paths { ".git" "node_modules" "target" }

    if { $directory == "" } { set directory "./" }

    foreach file [lsort -increasing [glob -nocomplain -directory $directory *]] {
        set should_be_excluded 0
        foreach path_to_exclude $excluded_paths {
            if { [regexp "$path_to_exclude" "$file"] } {
                set should_be_excluded 1
                break
            }
        }

        if { $should_be_excluded > 0 } { break }
        
        puts "$file"
        if { [file isdirectory "$file"] } { list_files "$file" }
    }
}

list_files "./"
