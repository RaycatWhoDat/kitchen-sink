package;

using StringUtils;

@:forward(push)
abstract Range(Array<Any>) from Array<Any> to Array<Any> {
  public function new(items: Array<Any>) {
    this = items;
  }

  @:arrayAccess function getByIterator(iterator: IntIterator) {
    var slice = [];
    for (index in iterator) {
      try {
        slice.push(this[index]);
      } catch (error) {
        throw new haxe.Exception('Index $index is out-of-bounds.');
      }
    }
    return slice;
  }
}
  
@:tink class FileIterators {
  public static function main() {
    var mockData = "MOCK_DATA.csv".byLine();
    var mockData2 = "MOCK_DATA.csv".byLine();
    var mockData3 = "MOCK_DATA.csv".byLine();
      
    var lines: Range = [];
    for ([line in mockData, line2 in mockData2, line3 in mockData3]) {
      lines.push([line, line2, line3]);
    };
    trace(lines[0...3]);
  }
}