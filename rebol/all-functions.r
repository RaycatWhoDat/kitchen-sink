REBOL []

foreach line read/lines open/read %../txr/docs/manpage.html [
    parse line [
        thru "class=^"tocanchor^">"
        copy listing: to "</a> <a href=^""
        thru "^">"
        copy entry: to </a></dt>
        to end
    ]
    if all [value? 'listing value? 'entry] [
        print rejoin [listing " - " entry]
        unset 'listing
        unset 'entry
    ]
]
