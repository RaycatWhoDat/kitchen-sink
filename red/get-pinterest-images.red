Red []

make-dir %images

pin-ids: copy system/options/args
remove-each pin-id pin-ids [empty? pin-id]

if empty? pin-ids [
    print "No pin IDs given."
    quit
]

print "Retrieving images for pins:"

foreach pin-id pin-ids [
    html: read to-url rejoin ["https://www.pinterest.com/pin/" pin-id]
    linked-url-rule: [to "img" thru ["href=" | "src="] skip keep to dbl-quote]
    links: parse html [collect [some linked-url-rule]]
    forall links [
        if none? find links/1 "i.pinimg" [continue]
        image-path: to-url links/1
        print rejoin [image-path "..."]
        destination: to-file rejoin ["images/" last split-path image-path]
        write/binary destination read/binary image-path
    ]
]