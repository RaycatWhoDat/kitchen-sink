REBOL []

item-count: 0

create-inventory-item: func [
    id [string!]
    name [string!]
    price [integer!]
] [
    set 'item-count item-count + 1
    object reduce/no-set [
        id: id
        name: name
        price: price
    ]
]

create-store-event: function [
    event-type [lit-word!]
    timestamp [integer!]
    payload [string!]
] [
    object reduce/no-set [
        event-type: event-type
        timestamp: timestamp
        payload: payload
    ]
]

create-store: function [
    name [string!]
    opening-time [integer!]
    closing-time [integer!]
    stock [map!]
    events [block!]
] [
    new-store: object [name: opening-time: closing-time: stock: events: none]

    set new-store/update-item-quantity function [
        item [object!]
        amount [integer!]
    ] [
        put self/stock item/id amount
    ]

    set new-store/purchase-item function [
        item [object!]
    ] [
        current-amount: get self/stock item/id
        if current-amount < 1 [return]
        append self/events create-store-event 'purchased date/utc item/id
        self/update-item-quantity item (current-amount - 1)
    ]

    set new-store/refund-item function [
        item [object!]
    ] [
        current-amount: get self/stock item/id
        append self/events create-store-event 'refunded date/utc item/id
        self/update-item-quantity item (current-amount + 1)
    ]

    make new-store reduce/no-set [
        name: name
        opening-time: opening-time
        closing-time: closing-time
        stock: stock
        events: events
    ]
]

item1: create-inventory-item "1" "Item 1 - A" 500
item2: create-inventory-item "2" "Item 2 - A" 750
item3: create-inventory-item "3" "Item 3 - A" 1000

store: create-store "Bob's Shop" 900 1700 (make map! item-count) []

print mold store

; store/update-item-quantity item1 10
; store/update-item-quantity item2 7
1; store/update-item-quantity item3 5

; store/purchase-item item1
