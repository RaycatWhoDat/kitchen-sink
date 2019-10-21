package;

import TestMacros.*;

class MacroTesting {
    public static function main() {
        inline function range(min: Int, max: Int) {
            return [for (_ in min...max) _];
        };

        trace(zip([0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11]));
        untyped __js__("console.log('we here')");
    }
}
