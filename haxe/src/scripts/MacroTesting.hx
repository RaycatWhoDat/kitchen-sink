package;

import TestMacros;

class MacroTesting {
  public static function main() {
    trace(TestMacros.zipIterators(0...12, 12...24, 24...36, 36...48));
  }
}