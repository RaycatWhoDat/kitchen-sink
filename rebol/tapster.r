card: make object! [
    number: "5555555555555555"
    cardholder-name: "Ray Perry"
    balance: $0.00
    ounces-poured: 0.0
]

reader-event: make object! [
    event-type: none
    timestamp: reduce [now/date now/time]
    payload: none
]

reader: make object! [
    current-card: none
    events: []
    insert-card: func [card] [
        new-event: make reader-event [event-type: "INSERTED"]
        new-event/payload: card/cardholder-name
        append self/events new-event
        self/current-card: card
    ]
    remove-card: does [
        new-event: make reader-event [event-type: "REMOVED"]
        new-event/payload: self/current-card/cardholder-name
        append self/events new-event
        self/current-card: none
    ]
    charge-card: func [ounces-poured price-per-ounce] [
        charge: to-money (ounces-poured * price-per-ounce)
        append self/events make reader-event [event-type: "CHARGED" payload: charge]
        self/current-card/ounces-poured: self/current-card/ounces-poured + ounces-poured
        self/current-card/balance: self/current-card/balance + charge
    ]
    display-stats: does [
        unless none? self/current-card [
            print rejoin ["Cardholder: " self/current-card/cardholder-name]
            print rejoin ["Total Amount: " self/current-card/balance]
            print rejoin ["Ounces Poured: " self/current-card/ounces-poured]
        ]
        print "Events: "
        foreach event self/events [
            print rejoin [event/timestamp " - " event/event-type " - " event/payload]
        ]
    ]
]

my-card: make card []
my-reader: make reader []

my-reader/insert-card my-card
my-reader/charge-card 10 0.5
my-reader/remove-card
my-reader/insert-card my-card
my-reader/display-stats
