REBOL []

random/seed now

blackjack-card: make object! [value1: value2: 0 display-value: ""]

blackjack-hand: make object! [
    cards: []
    total: [0 0]
    status: does [
        foreach card cards [print card/display-value]
        print rejoin ["Total value: " self/total/1 " (" self/total/2 ")"]
    ]
    hit: func [deck] [
        card: deck/hit
        append self/cards card
        self/total: reduce [(self/total/1 + card/value1) (self/total/2 + card/value2)]
    ]
]

blackjack-deck: make object! [
    cards: []
    reset: does [
        values: ["2" "3" "4" "5" "6" "7" "8" "9" "10" "J" "Q" "K" "A"]
        suits: [♥ ♠ ♦ ♣]
        self/cards: collect [
            foreach suit suits [
                foreach value values [
                    card: make blackjack-card []
                    either value = "A" [
                        card/value1: 1
                        card/value2: 11
                    ] [
                        card-value: attempt [to-integer value]
                        card/value1: card/value2: either none? card-value [10] [card-value]
                    ]
                    card/display-value: rejoin [value suit]
                    keep card
                ]
            ]
        ]
    ]
    hit: does [pick self/cards random length? self/cards]
]

my-deck: make blackjack-deck []
my-deck/reset
my-player-hand: make blackjack-hand []

until [
    my-player-hand/hit my-deck
    my-player-hand/total/1 > 21
]

my-player-hand/status
print "You've busted!"
