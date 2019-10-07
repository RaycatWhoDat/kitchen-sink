package;

import hxd.*;

class Hello extends hxd.App {
  static public var message: h2d.Text;
  
  override function init() {
    message = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
    message.text = "Hello, HashLink!";
    message.dropShadow = { dx: 0.5, dy: 0.5, color: 0x00FF00, alpha: 0.8 };
    message.x = 10;
    message.y = 10;
  }

  override function update(dt: Float) {
    if (Key.isDown(Key.Q)) System.exit();

    if (Key.isDown(Key.LEFT)) message.x -= 1;
    if (Key.isDown(Key.RIGHT)) message.x += 1; 
    if (Key.isDown(Key.UP)) message.y -= 1;
    if (Key.isDown(Key.DOWN)) message.y += 1;
  }
  
  static function main() {
    new Hello();
  }
}

// Local Variables:
// compile-command: "cd ../.. && haxe HelloHashlink.hxml"
// End: