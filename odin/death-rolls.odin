package main

import "core:math/rand"
import "core:fmt"

Player :: struct {
  name: string,
  last_roll: int
}

new_player :: proc () -> Player {
  @(static) number_of_players := 0
  number_of_players += 1
  return Player { fmt.aprintf("Player %d", number_of_players), 999 }
}

roll :: proc (self: ^Player, starting_number: int) {
  self.last_roll = rand.int_max(starting_number) + 1
  fmt.printf("Random! %s rolls a %d (out of %d).\n", self.name, self.last_roll, starting_number)
}

main :: proc () {
  current_player, other_player := new_player(), new_player()
  
  for other_player.last_roll != 1 {
    roll(&current_player, other_player.last_roll)
    current_player, other_player = other_player, current_player
  }

  fmt.printf("Game over! %s wins!\n", current_player.name)
}


