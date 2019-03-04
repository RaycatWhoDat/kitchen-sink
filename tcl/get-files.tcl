#!/bin/sh
# the next line restarts using tclsh \
    exec tclsh "$0" ${1+"$@"}

set indentation_level 2

proc generate_indent { traversal_level } {
    global indentation_level
    set indentation ""
    for {set index 0} {$index < [expr $traversal_level * $indentation_level]} {incr index} {
        append indentation " "
    }
    return $indentation
}

proc list_files { directory traversal_level } {
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

        if { $should_be_excluded } { break }

        puts "[generate_indent $traversal_level][regsub $directory $file {}]"
        if { [file isdirectory "$file"] } { list_files "$file" [expr $traversal_level + 1] }
    }
}

list_files $argv 0
