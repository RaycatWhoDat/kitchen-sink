set rawFile [open "./AC-460.csv" r+]
set parsedFile [lrange [split [read $rawFile] \n] 1 end]
foreach {line} $parsedFile {
    puts $line
}
