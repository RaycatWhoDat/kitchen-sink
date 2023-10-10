import "dart:math";

class Player {
  static int numberOfPlayers = 0;
  late String name;
  int lastRoll = 1000;

  Player() {
    numberOfPlayers++;
    name = "Player $numberOfPlayers";
  }

  roll(int startingNumber) {
    lastRoll = Random().nextInt(startingNumber) + 1;
    print("Random! $name rolls a $lastRoll (out of $startingNumber).");
  }
}

main() {
  var currentPlayer = Player();
  var otherPlayer = Player();

  while (otherPlayer.lastRoll != 1) {
    currentPlayer.roll(otherPlayer.lastRoll);
    var temp = currentPlayer;
    currentPlayer = otherPlayer;
    otherPlayer = temp;
  }

  print("Game over! ${currentPlayer.name} wins!");
}
