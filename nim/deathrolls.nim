import std/[strformat, random]

randomize()

var numberOfPlayers = 0;

type Player = ref object
  name: string
  lastRoll: int

proc newPlayer(): Player =
  inc numberOfPlayers
  Player(name: &"Player {$numberOfPlayers}", lastRoll: 1000)
  
method roll(self: Player, startingNumber: int): int =
  self.lastRoll = rand(1..startingNumber)
  echo &"Random! {self.name} rolls a {$self.lastRoll} (out of {$startingNumber})."
  self.lastRoll

var
  currentPlayer = newPlayer()
  otherPlayer = newPlayer()

while currentPlayer.lastRoll != 1:
  if currentPlayer.roll(otherPlayer.lastRoll) != 1:
    swap(currentPlayer, otherPlayer)

echo &"Game over! {currentPlayer.name} wins!"

