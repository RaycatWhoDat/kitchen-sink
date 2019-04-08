import sys.FileSystem.readDirectory;
import sys.FileSystem.isDirectory;

class GetFiles {
  static function printFiles(directoryPath = '..', traversalLevel = 0) {
    var ignoredPaths = ['.git', 'node_modules', 'target', 'love'];
    
    for (entry in readDirectory(directoryPath)) {
      if (ignoredPaths.indexOf(entry) > -1) continue;
      trace([for (index in 0...(traversalLevel * 2)) ' '].join('') + entry);
      if (isDirectory(directoryPath + '/' + entry)) GetFiles.printFiles(directoryPath + '/' + entry, traversalLevel + 1);
    }
  }
  
  static function main() {
    if (Sys.args().length < 1) return;
    GetFiles.printFiles(Sys.args()[0]);
  }
}

// Local Variables:
// compile-command: "haxe ../../GetFiles.hxml"
// eval: (setq funda-haxe-indent-offset 2)
// End: 
