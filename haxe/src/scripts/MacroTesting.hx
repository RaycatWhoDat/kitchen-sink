package;

import TestMacros.*;

class MacroTesting {
  public static function main() {
    inline function range(min: Int, max: Int) {
      return [for (_ in min...max) _];
    }
    
    trace(zip(range(0, 12), range(12, 24), range(24, 36), range(36, 48)));
  }
}