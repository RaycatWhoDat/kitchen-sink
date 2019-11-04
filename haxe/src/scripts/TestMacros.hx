package;

import haxe.macro.Context;
import haxe.macro.Expr;
import RangeTools;
using haxe.macro.Tools;

class TestMacros {
    public static macro function printSomething(?message: ExprOf<String>) {
      return macro { trace($message); }
    }
    
    public static macro function zip(sequences: Array<Expr>) {
        #if macro
        var numberOfElementsInFirstSequence = null;
        var allSequences = [
            for (sequence in sequences) {
                switch (sequence.expr) {
                case ECall({ pos: _, expr: EConst(CIdent(range)) }, args):
                    var argValues = [for (arg in args) arg.getValue()];
                    if (numberOfElementsInFirstSequence == null && argValues.length > 1) {
                        numberOfElementsInFirstSequence = 1 + argValues[1] - argValues[0];
                    }

                    var results = [];
                    for (number in RangeTools.range($v{argValues[0]}, $v{argValues[1]})) {
                        results.push(macro $v{number});
                    }
                    
                    macro $a{results};
                case EArrayDecl(_):
                    if (numberOfElementsInFirstSequence == null) {
                        numberOfElementsInFirstSequence = sequence.getValue().length;
                    }
                    $v{sequence};
                default:
                    $v{sequence};
                }
            }
        ];

        var numberOfSequences = allSequences.length;
        
        return macro {
            [
                for (xIndex in 0...$v{numberOfElementsInFirstSequence}) {
                    for (yIndex in 0...$v{numberOfSequences}) {
                        $a{allSequences}[yIndex][xIndex];
                    }
                }
            ];
        };
        #else
        trace("Macros are disabled.");
        #end
    }
}
