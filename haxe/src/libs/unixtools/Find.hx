package unixtools;

using Lambda;

class Find {
  public static function recursiveFind(relativeRoot: String, ?pattern: EReg) {
    var filePaths = [];
    var _filePaths = [];
    _recursiveFind(filePaths, relativeRoot);
    if (pattern != null) {
      _filePaths = filePaths.filter(function (filePath) { return pattern.match(filePath); });
    } else {
      _filePaths = filePaths;
    }
    return _filePaths;
  }
  
  private static function _recursiveFind(_filePaths, _relativeRoot: String) {
    for (filePath in sys.FileSystem.readDirectory(_relativeRoot)) {
      var currentPath = haxe.io.Path.join([_relativeRoot, filePath]);
      if (sys.FileSystem.isDirectory(currentPath)) {
        _recursiveFind(_filePaths, currentPath);
      } else {
        _filePaths.push(currentPath);
      }
    }
  }
}


