package require json

set client [socket localhost 8090]
fconfigure $client -buffering line
puts $client "This is the first test."
puts $client "This is the second test."
puts $client "This is the third test."
set json [::json::json2dict "\{ \"userId\"\: 1, \"id\"\: 1, \"title\"\: \"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\", \"body\"\: \"quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto\"}"]
puts $client [dict get $json "body"]
close $client
