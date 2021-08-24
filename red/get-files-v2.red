Red []

ignored-paths: [".git/" "node_modules/" "target/" "love/" ".dub/" "dist/"]

do-files: function [
    "Iterates over each listing in FILE-PATH and runs CALLBACK on the value."
    file-path [file! string!] "The path to the file."
    callback [word! block!] "The function to evaluate each iteration."
] [
    listing: read to-red-file file-path
    
    foreach entry sort listing [
        unless none? (find ignored-paths to-string entry) [continue]
        do either block? callback [
            append to block! callback entry
        ] [
            reduce [callback entry]
        ]
        if dir? entry [
            new-callback: copy callback
            indent-level: find new-callback integer!
            unless none? indent-level [
                change indent-level (first indent-level) + 1
            ]
            do-files rejoin [file-path entry] new-callback 
        ]
    ]
]

print-file: function [
    "Print a line with indentation."
    indent-level [integer!] "The level of indentation."
    file [file! string!] "The string to display."
] [
    repeat index (2 * indent-level) [prin space]
    print file
]

do-files "../" [print-file 0]