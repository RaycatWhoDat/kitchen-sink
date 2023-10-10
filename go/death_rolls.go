package main

import (
	"fmt"
	"math/rand"
)

var numberOfPlayers = 0

type Player struct {
	name     string
	lastRoll int32
}

func NewPlayer() Player {
	numberOfPlayers++
	return Player{fmt.Sprintf("Player %d", numberOfPlayers), 1000}
}

func (p *Player) Roll(startingNumber int32) {
	p.lastRoll = rand.Int31n(startingNumber) + 1
	fmt.Printf("Random! %s rolls a %d (out of %d).\n", p.name, p.lastRoll, startingNumber)
}

func main() {
	currentPlayer, otherPlayer := NewPlayer(), NewPlayer()

	for otherPlayer.lastRoll != 1 {
		currentPlayer.Roll(otherPlayer.lastRoll)
		currentPlayer, otherPlayer = otherPlayer, currentPlayer
	}

	fmt.Printf("Game over! %s wins.\n", currentPlayer.name)
}
