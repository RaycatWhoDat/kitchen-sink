package;

import haxe.macro.Expr;
import haxe.macro.Context;

using StringTools;
using haxe.macro.Tools;

class SimpleCalculator {
    public static function main() {
        var stdin = Sys.stdin();

        trace("Enter a list of numbers separated by spaces: ");
        var input = stdin.readLine();
        var numbers = [
            for (fragment in input.trim().split(" ")) {
                if (Std.parseFloat(fragment) != null) Std.parseFloat(fragment);
            }
        ];
        var isComplete = false;
        var result = 0.0;

        generateOpSwitch();

        trace('The answer is: $result');
    }

    macro static function generateOpSwitch() {
        var operations = ["+", "-", "*", "/"];
        var switchStart = "switch (stdin.readLine().trim()) {";
        var switchEnd = "}";
        var switchFragments = [switchStart];

        for (operation in operations) {
            var newSwitchCase = '
                case "$operation":
                while (numberIterator.hasNext()) {
                    result $operation= numberIterator.next();
                }
                isComplete = true;
            ';
            
            switchFragments.push(newSwitchCase);
        }

        switchFragments.push(switchEnd);

        var switchStatement = Context.parse(switchFragments.join("\n"), Context.currentPos());
        
        return macro {
            while (!isComplete) {
                trace("Operation? ");
                var numberIterator = numbers.iterator();

                ${switchStatement};
            }
        };
    }
}
