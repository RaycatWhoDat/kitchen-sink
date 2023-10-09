REBOL []

random/seed now

number-of-players: 0

make-player: function [] [
    ++ number-of-players
    make object! [
        name: rejoin ["Player " number-of-players]
        last-roll: 1000
    ]
]

roll: function [player starting-number] [
    player/last-roll: random starting-number
    print rejoin ["Random! " player/name " rolls a " player/last-roll " (out of " starting-number ")."] 
]

current-player: make-player
other-player: make-player

until [
    roll current-player other-player/last-roll
    set [current-player other-player] reduce [other-player current-player]
    other-player/last-roll == 1
]

print rejoin ["Game over! " current-player/name " wins!"]

