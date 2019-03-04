package require csv
package require struct::matrix

struct::matrix accounts
accounts add columns 3
set raw_file [open test.csv]
csv::read2matrix $raw_file accounts ,
close $raw_file
puts [accounts get column 0]
accounts destroy
