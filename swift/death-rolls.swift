struct Player {
    static var numberOfPlayers: Int = 0

    let name = "Player \(numberOfPlayers + 1)"
    var lastRoll = 1000

    init() {
        Player.numberOfPlayers += 1
    }
    
    mutating func deathRoll(_ startingNumber: Int) {
        lastRoll = Int.random(in: 1...startingNumber)
        print("Random! \(name) rolls a \(lastRoll) (out of \(startingNumber)).")
    }
}

var currentPlayer = Player(), otherPlayer = Player()
while otherPlayer.lastRoll != 1 {
    currentPlayer.deathRoll(otherPlayer.lastRoll)
    swap(&currentPlayer, &otherPlayer)
}

print("Game over! \(currentPlayer.name) wins!")
