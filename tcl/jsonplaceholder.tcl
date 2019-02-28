package require http
package require json

set url "http://jsonplaceholder.typicode.com/posts"
set token [http::geturl $url -timeout 30000]
set status [http::status $token]
set answer [http::data $token]
http::cleanup $token

set posts [::json::json2dict $answer]
dict for {key post} $posts {
    puts "[dict get $post userId] | [dict get $post id] \n"
    puts [dict get $post title]\n
    puts [dict get $post body]\n
}

# Local Variables:
# compile-command: "tclsh jsonplaceholder.tcl"
# End:
