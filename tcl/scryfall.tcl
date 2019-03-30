package require http
package require json
package require tls

# From http://rosettacode.org/wiki/URL_encoding#Tcl
# Encode all except "unreserved" characters; use UTF-8 for extended chars.
# See http://tools.ietf.org/html/rfc3986 §2.4 and §2.5
proc urlEncode {str} {
    set uStr [encoding convertto utf-8 $str]
    set chRE {[^-A-Za-z0-9._~\n]};		# Newline is special case!
    set replacement {%[format "%02X" [scan "\\\0" "%c"]]}
    return [string map {"\n" "%0A"} [subst [regsub -all $chRE $uStr $replacement]]]
}

proc noCardsFound {} {
    puts "No cards found."
    exit
}

proc accessCardValue {cardFace propName} {
    if {[dict exists $cardFace $propName]} {
        return [dict get $cardFace $propName]
    } else {
        return ""
    }
}

proc formatTypeLine {type_line} {
    set typeLine [split $type_line "â"]
    if {[expr [llength $typeLine] > 1]} {
        return [join [list [lindex $typeLine 0] [lindex $typeLine end]] -]
    } else {
        return "$typeLine"
    }
}

proc printCard {cardFace {otherCardFace ""}} {
    if {! [string is list $cardFace]} return
    puts "[accessCardValue $cardFace name] [accessCardValue $cardFace mana_cost]"
    if {[dict exists $otherCardFace name]} {
        puts "(This card transforms into [dict get $otherCardFace name].)"
    }
    puts [formatTypeLine [accessCardValue $cardFace type_line]]
    puts [accessCardValue $cardFace oracle_text]\n
}

if {[expr $argc < 1]} noCardsFound

set query [urlEncode $argv]

http::register https 443 tls::socket
set url "https://api.scryfall.com/cards/search?q=$query"
set token [http::geturl $url -timeout 30000]
set status [http::status $token]
set answer [http::data $token]
http::cleanup $token
http::unregister https

set cardResults [dict get [::json::json2dict $answer] data]

foreach card $cardResults {
    set cardFaces [list $card]
    if {[dict exists $card card_faces] && [expr [llength [dict get $card card_faces]] > 0]} {
        set cardFaces [dict get $card card_faces]
    } 

    if {[expr [llength $cardFaces] > 1]} {
        printCard [lindex $cardFaces 0] [lindex $cardFaces 1]
        printCard [lindex $cardFaces 1] [lindex $cardFaces 0]
    } else {
        printCard [lindex $cardFaces 0]
    }
}

# Local Variables:
# compile-command: "./tclkit scryfall.tcl"
# End:
