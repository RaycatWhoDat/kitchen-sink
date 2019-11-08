@:tink class Echo {
  public static function main() {
    var currentList = [for ([x in 0...12, y in 12...24, z in 24...36]) for (item in [x, y, z]) item];
    trace(currentList);
  }
}

// Local Variables:
// compile-command: "haxe -L tink_lang -L hxcpp --main Echo --cpp EchoCpp"
// End:
