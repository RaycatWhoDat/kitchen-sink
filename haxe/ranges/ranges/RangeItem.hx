package ranges;

@:structInit
class RangeItem {
  public var value: Null<Any>;

  public function toString(): String {
    return "RangeItem: " + this.value;
  }
}