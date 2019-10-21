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

  public static macro function zip(sequences: Array<Expr>) {
      var allSequences = [for (sequence in sequences) $v{sequence}];
      var numberOfSequences = allSequences.length;
      var numberOfElementsInFirstSequence = allSequences[0].getValue().length;
      
      return macro {
          [
              for (xIndex in 0...$v{numberOfElementsInFirstSequence}) {
                  for (yIndex in 0...$v{numberOfSequences}) {
                      $a{allSequences}[yIndex][xIndex];
                  }
              }
          ];
      };
  }
}
