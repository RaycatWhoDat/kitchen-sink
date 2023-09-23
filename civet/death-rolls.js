let numberOfPlayers = 0

class Player {
  name = `Player ${++numberOfPlayers}`;
  lastRoll = 1000
  roll(startingNumber) {
    let ret;
    ret = this.lastRoll = Math.floor((Math.random() * startingNumber) + 1)
    console.log(`Random! ${this.name} rolls a ${this.lastRoll} (out of ${startingNumber}).`)
    return ret
  }
};

let [currentPlayer, otherPlayer] = [new Player, new Player]

while (!(otherPlayer.lastRoll === 1)) {
  currentPlayer.roll(otherPlayer.lastRoll);
  [currentPlayer, otherPlayer] = [otherPlayer, currentPlayer]
}

console.log(`Game over! ${currentPlayer.name} wins!`)
