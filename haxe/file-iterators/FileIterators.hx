package;

using StringUtils;

@:tink class FileIterators {
  public static function main() {
    var mockData = "MOCK_DATA.csv".byLine();
    var mockData2 = "MOCK_DATA.csv".byLine();
    var mockData3 = "MOCK_DATA.csv".byLine();
    
    var lines = [for ([line in mockData, line2 in mockData2, line3 in mockData3]) [line, line2, line3]].slice(0,3);
    trace(lines);
  }
}
