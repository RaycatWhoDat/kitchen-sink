package;

import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;

class TestMacros {
  public static macro function printSomething(?message: ExprOf<String>) {
    return macro {
      trace($message);
    };
  }

  public static macro function zipIterators(sequences: Array<Expr>) {
    var zippedResults = [];
    var firstIterator = $v{$a{sequences}[0]};

    for (_ in firstIterator) {
      for (index in 0...$v{sequences.length}) {
        zippedResults.push(macro ${$a{sequences}[index]}.next());
      }
    }

    return macro $a{zippedResults};
  }
}