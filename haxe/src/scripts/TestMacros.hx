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
    var zippedResults = [];
    var firstArray = $a{sequences[0]};

    trace(firstArray.toString());
    
    // for (xIndex in firstArray) {
    //   for (yIndex in 0...$v{sequences.length}) {
    //     zippedResults.push(macro ${$v{sequences}[yIndex][xIndex]});
    //   }
    // }

    // return macro {
    //   for (xIndex in 0...$sequences[0].length ) {
    //     trace(xIndex);
    //   }
    // };

    
    // return macro { $zippedResults; };
    // return macro {
    //   for (x in firstArray.getValue()) {
    //     for (y in 0...$v{sequences.length}) {
    //       macro zippedResults.push(sequences[y][x].getValue());
    //     }
    //   };
    //   $zippedResults;
    // };
    return macro null;
  }
}