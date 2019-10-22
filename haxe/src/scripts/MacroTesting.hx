package;

import TestMacros.*;
import RangeTools.*;

class MacroTesting {
    public static function main() {
        trace(zip(range(0, 5), [4, 5, 6, 7, 8, 9], range(9, 14)));
    }
}
