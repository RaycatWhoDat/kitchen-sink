package ranges;

class Range {
  public var source: Any;
  private var begin = 0;
  private var end = 0;
  
  public function new(source: Any, ?begin: Int, ?end: Int) {
    this.source = source;
    this.begin = begin;
    this.end = end;
  }
}
