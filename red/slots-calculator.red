Red []

reel-height: 5
number-of-reels: 6
minimum-of-winning-reels: 4

max-multiplier: 50000.00
payouts-table: context [
    TEN: [0.15 0.20 0.30]
    J: [0.20 0.30 0.40]
    Q: [0.30 0.40 0.50]
    K: [0.25 0.50 1.00]
    A: [0.50 1.00 2.00]
    SCROLL: [3.00 5.00 10.00]
    URN: [10.00 25.00 50.00]
    HELMET: [50.00 100.00 200.00]
    PEGASUS: [250.00 500.00 1000.00]
    ATHENA: reduce [5000.00 25000.00 max-multiplier]
]

minimum-bet: $1.00
maximum-bet: $100.00
current-bet: $100.00

print ["Initial bet:" current-bet]

random/seed now/precise
symbols: words-of payouts-table
reel: collect [repeat index reel-height [keep copy symbols]]
all-reels: collect [repeat reel-number number-of-reels [keep reduce [random copy reel]]]

new-symbols: does [
    symbol-selection: collect [
        foreach reel all-reels [
            new-reel: at reel random (length? reel) - reel-height
            keep reduce [take/part new-reel reel-height]
        ]
    ]
    
    print space
    print "Last result:"
    probe new-line/all symbol-selection on
    symbol-selection
]

check-for-win: function [symbol-selection] [
    reel-number: 1
    possible-wins: unique symbol-selection/1
    foreach reel (at symbol-selection 2) [
        reel-number: reel-number + 1
        remove-each possibility possible-wins [
            all [
                none? find reel possibility
                reel-number <= minimum-of-winning-reels
            ]
        ]
    ]
    if not empty? possible-wins [
        print space
        print "Possible wins:"
        probe new-line/all possible-wins off
    ]
    possible-wins
]

get-winning-reels-and-numbers: function [symbol-selection possible-wins] [
    remove-each reel symbol-selection [
        no-valid-win: false
        forall possible-wins [
            if all [none? find reel first possible-wins] [
                no-valid-win: true
                break
            ]
        ]
        possible-wins: at possible-wins 1
        no-valid-win
    ]

    number-of-symbols: to-map collect [
        repeat index (length? possible-wins) [
            keep reduce [possible-wins/:index 0]
        ]
    ]

    foreach reel symbol-selection [
        foreach win possible-wins [
            if not none? find reel win [
                put number-of-symbols win ((select number-of-symbols win) + 1)
            ]
        ]
    ]
    
    reduce [symbol-selection number-of-symbols]
]

new-spin: does [
    spin: new-symbols
    possible-wins: check-for-win spin
    winning-reels-and-numbers: get-winning-reels-and-numbers spin possible-wins
    winning-reels: take winning-reels-and-numbers
    winning-numbers: last winning-reels-and-numbers
    
    if not empty? possible-wins [
        print space
        print "Winning reels:"
        probe new-line/all winning-reels on
    ]
    calculate-payout winning-numbers possible-wins
    winning-reels
]

calculate-payout: function [winning-numbers possible-wins] [
    all-multipliers: collect [
        foreach win possible-wins [
            number-of-winning-symbols: select winning-numbers win
            pay-index: number-of-reels - number-of-winning-symbols + 1
            pay-table: reverse payouts-table/:win
            either pay-index <= (length? pay-table) [keep pay-table/:pay-index] [0]
        ]
    ]

    total-multiplier: to-float sum all-multipliers
    
    either not zero? total-multiplier [
        print space
        total-win: current-bet * total-multiplier
        print [
            "Total multiplier:"
            rejoin [
                either total-multiplier >= 1 [
                    to-integer total-multiplier
                ][
                    total-multiplier
                ]
                #"x"
            ]
        ]
        print ["Total win:" total-win]
    ] [
        0.0
    ]
]