/*
  This doesn't work, unfortunately.
 */

package;

import haxe.macro.Expr;

using haxe.macro.Tools;

class LoopMacro {
  public static macro function loop(exprs: Array<Expr>) {
    trace([for (expr in exprs) expr]);
    return macro null;
  }

  public static function main() {
    var characters = ['a', 'b', 'c'];
    
    loop();
    loop(1);
    loop(1 = 2);
    // loop(for character in characters);
  }
}
