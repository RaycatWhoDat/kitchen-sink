Red []

new-card: function [_number _cardholder-name] [
    make object! [
        number: _number
        cardholder-name: _cardholder-name
        balance: $0.00
        ounces-poured: 0.00
    ]
]

new-event: function [_type _payload] [
    make object! [
        type: _type
        timestamp: to-integer now
        payload: _payload
    ]
]

new-reader: function [] [
    make object! [
        current-card: none
        events: []
        insert-card: function [card] [
            append self/events new-event "INSERTED" card/cardholder-name
            self/current-card: card
        ]
        remove-card: function [] [
            append self/events new-event "REMOVED" self/current-card/cardholder-name
            self/current-card: none
        ]
        charge-card: function [ounces-poured price-per-ounce] [
            charge: to-money ounces-poured * price-per-ounce
            append self/events new-event "CHARGED" charge
            self/current-card/balance: self/current-card/balance + charge
            self/current-card/ounces-poured: self/current-card/ounces-poured + ounces-poured
        ]
        display-stats: function [] [
            foreach event events [
                print [event/timestamp #"-" event/type #"-" event/payload]
            ]
        ]
    ]
]

card: new-card "5555555555555555" "Ray Perry"
reader: new-reader

reader/insert-card card
reader/charge-card 10.1 0.79
reader/remove-card
reader/insert-card card
reader/display-stats
