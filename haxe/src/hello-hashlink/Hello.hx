package;

import hxd.*;

class Hello extends hxd.App {
  override function init() {
    var message = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
    message.text = "Hello, HashLink!";
    message.dropShadow = { dx: 0.5, dy: 0.5, color: 0x00FF00, alpha: 0.8 };
    message.x = 10;
    message.y = 10;
    message.scale(7);
  }

  override function update(dt: Float) {
    if (Key.isDown(Key.Q)) System.exit();
  }
  
  static function main() {
    new Hello();
  }
}

// Local Variables:
// compile-command: "cd ../.. && haxe HelloHashlink.hxml"
// End: