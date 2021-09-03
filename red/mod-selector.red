Red [needs: view]

character-limit: 3

reset-files: does [
    results-count/visible?: false
    files/filtered-files: copy files/all-files
]

delete-item: does [
    file-name: pick files/filtered-files file-listing/selected
    if none? file-name [exit]
    attempt [delete file-name]
    alter files/all-files file-name
    remove at files/filtered-files file-listing/selected
    print rejoin [file-name { deleted.}]
]

search-files: does [
    search-query: attempt [to-string search-bar/data]
    if any [
        none? search-query
        (length? search-query) < character-limit
    ] [
        if (length? files/filtered-files) <> length? files/all-files [reset-files]
        exit
    ]
    
    results-count/visible?: true
    files/filtered-files: collect [
        foreach file-name files/all-files [
            if none? find file-name search-query [continue]
            keep file-name
        ]
    ]
    
    results-count/text: rejoin [length? files/filtered-files { results on } dbl-quote search-query dbl-quote]
]

files: reactor [
    all-files: read %.
    filtered-files: copy all-files
]

text-color: either system/platform = 'Windows [white] [black]

mod-selector: layout [
    title {Mod Selector}
    across
    search-bar: field text-color 300x24 focus on-change [search-files]
    clear-search-button: button 24x24 "X" on-click [
        search-bar/data: none 
    ] 
    return
    below
    results-count: text 334x24 "0 results" hidden
    file-listing: text-list text-color 334x500 react [face/data: files/filtered-files]
    button "Delete" 334x32 on-click [
        delete-item
        show file-listing
    ]
]

view mod-selector
