package;

import sys.io.*;

@:keep
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

@:keep
class StringUtils {
  public static function byLine(fileName: String) { return new FileIterator(fileName); }
}