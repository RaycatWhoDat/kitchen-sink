Red []

; TODO: Why doesn't the countdown remove itself in time?

COUNTDOWN_DELAY: 3

state: make reactor! [
    picture-count: 0
    countdown: COUNTDOWN_DELAY
    last-taken-picture: none 
]

; Check for existing pictures
foreach file read %. [
    file-parts: parse form file [collect ["picture-" keep to "." ".jpg"]]
    unless none? file-parts/1 [
        new-number: first transcode form file-parts/1
        if new-number > state/picture-count [state/picture-count: new-number]
    ]
]

take-picture: does [
    countdown/visible?: true
    countdown/rate: 1
    last-picture/visible?: false
]

save-picture: does [
    file-name: load rejoin [mold '% "picture-" state/picture-count: state/picture-count + 1 ".jpg"]
    save/as file-name to-image cam 'jpeg
    state/last-taken-picture: file-name

    last-picture/visible?: true
]

view [
    title "Photo Booth"

    style countdown-style: text "" 640x480 middle center font-size 128 bold font-color white rate 1 hidden

    below

    counter: h4 640x24 middle center bold react [
        counter/text: rejoin ["Picture #" state/picture-count + 1]
    ]

    cam: camera 640x480 select 1

    at cam/offset
    countdown: countdown-style react [countdown/text: to-string state/countdown] on-time [
        if countdown/visible? [state/countdown: state/countdown - 1]
        if zero? state/countdown [
            countdown/visible?: false
            countdown/rate: none
            state/countdown: COUNTDOWN_DELAY
            save-picture
        ]
    ]

    at (cam/offset + cam/size - 165x125)
    last-picture: image 160x120 hidden react [
        unless none? state/last-taken-picture [
            last-picture/image: load/as state/last-taken-picture 'jpeg
        ]
    ]

    button 640x75 "Take Picture" font-size 16 on-click [take-picture]
]

