import love.Love;
import love.graphics.GraphicsModule as Lg;

class Game {
  private var testMessage: String = "This is a test.";

  public function new() {
    
  }
  
  public function load(args: lua.Table<Dynamic, Dynamic>) {
    
  }

  public function update(dt: Float) {

  }

  public function draw() {
    Lg.print(this.testMessage, 10, 10);
  }
}


class LuaTestApp {
  public static function main() {
    var game = new Game();
    
    Love.load = game.load.bind();
    Love.update = game.update.bind();
    Love.draw = game.draw.bind();
  }
}

// Local Variables:
// compile-command: "haxe luaTestApp.hxml"
// End: