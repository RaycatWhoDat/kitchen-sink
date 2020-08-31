package;

import sys.io.*;

class FileIterator {
  var fileHandle: FileInput;
  
  public function new(fileName: String) {
    try {
      this.fileHandle = File.read(fileName);
    } catch (error) {
      throw error;
    }
  }

  public function hasNext(): Bool {
    return fileHandle != null && !fileHandle.eof();
  }

  public function next() {
    return try { this.fileHandle.readLine(); } catch (error) { null; }
  }
}

@:tink class FileIterators {
  public static function main() {
    var mockData = new FileIterator("MOCK_DATA.csv");
    var mockData2 = new FileIterator("MOCK_DATA.csv");
    var mockData3 = new FileIterator("MOCK_DATA.csv");
    
    var lines = [for ([line in mockData, line2 in mockData2, line3 in mockData3]) [line, line2, line3]].slice(0,3);
    trace(lines);
  }
}
