Red [needs: 'view]

base-scryfall-url: [https api.scryfall.com cards]
search-url-parts: compose [(base-scryfall-url) search]

card-url: function [card-id] [
    base-card-url: copy [https c1.scryfall.com file scryfall-cards large front]
    buckets: copy []
    extract/into (take/part copy card-id 2) 1 buckets
    append base-card-url buckets
    to-url compose [(base-card-url) (rejoin [card-id {.jpg}])]
]

search-for-cards: function [search-criteria] [
    if none? search-criteria [
        print "No search criteria given."
        exit
    ]

    print ["Searching for:" search-criteria]

    search-url: append to-url copy search-url-parts rejoin [{?q=} search-criteria] 
    ?? search-url
    response: copy ""
    call/output rejoin [{curl -XGET } search-url] response
    search-results: load/as response 'json
    
    if none? attempt [search-results/data/1/id] [
        print "No card found."
        exit
    ]

    card-image-data: load/as (read/binary card-url search-results/data/1/id) 'jpeg
    card-image/size: card-image-data/size / 2
    card-image/image: card-image-data
    card-image/visible?: true
]

view [
    title "Scryfall Card Search"
    size 360x530
    below
    across
    search-bar: field 250x32 [search-for-cards search-bar/data]
    search-button: button 64x32 "Search" on-click [search-for-cards search-bar/data]
    return
    below
    card-image: image hidden
]