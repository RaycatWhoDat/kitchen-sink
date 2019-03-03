import love.Love;

import love.graphics.DrawMode;
import love.graphics.GraphicsModule as Lg;

import love.event.EventModule as Le;
import love.keyboard.KeyboardModule as Lk;

class Player {
  public var x: Float = 0;
  public var y: Float = 0;
  public var width: Int = 0;
  public var color: Array<Float> = [0, 0, 0];
  
  public function new(x: Float, y: Float, width: Int, ?color: Array<Float>) {
    this.x = x;
    this.y = y;
    this.width = width;
    if (color != null) this.color = color;
  }

  public function update(dt: Float) {
    if (Lk.isDown("left")) this.x -= 1;
    if (Lk.isDown("right")) this.x += 1;
    if (Lk.isDown("up")) this.y -= 1;
    if (Lk.isDown("down")) this.y += 1;
  }
  
  public function draw() {
    Lg.setColor(this.color[0], this.color[1], this.color[2], 0.3);
    Lg.rectangle(DrawMode.Fill, this.x, this.y, this.width, this.width);
    Lg.setColor(this.color[0], this.color[1], this.color[2], 1);
    Lg.rectangle(DrawMode.Line, this.x, this.y, this.width, this.width);
    Lg.setColor(1, 1, 1, 1);
  }
}

class Game {
  static var player: Player = new Player(0, 0, 64, [1, 0, 0]);
  
  public static function load(args: lua.Table<Dynamic, Dynamic>) {
    
  }

  public static function keypressed(key: String, scanCode: String, isRepeat: Bool) {
    if (key == "q") Le.quit();
  }
  
  public static function update(dt: Float) {
    player.update(dt);
  }

  public static function draw() {
    player.draw();
  }
}


class LuaTestApp {
  public static function main() {
    Love.load = Game.load;
    Love.update = Game.update;
    Love.keypressed = Game.keypressed;
    Love.draw = Game.draw;
  }
}

// Local Variables:
// compile-command: "haxe luaTestApp.hxml"
// End: