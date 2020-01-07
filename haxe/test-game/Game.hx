import Base;

class Game {
  public static function main() {
    Love.load = Base.load;
    Love.update = Base.update;
    Love.keypressed = Base.keypressed;
    Love.draw = Base.draw;
  }
}
// Local Variables:
// compile-command: "haxe ../../TestGame.hxml"
// End:
