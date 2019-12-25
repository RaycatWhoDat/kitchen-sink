import sys.FileSystem.readDirectory;
import sys.FileSystem.isDirectory;

class GetFiles {
  static function printFiles(directoryPath = "..", traversalLevel = 0) {
      var ignoredPaths = [
          ".git",
          "node_modules",
          "target",
          "love",
          "dist",
          "build",
          "_build",
          ".dub"
      ];
    
      for (entry in readDirectory(directoryPath)) {
          if (ignoredPaths.indexOf(entry) > -1) continue;
          Sys.println([for (index in 0...(traversalLevel * 2)) " "].join("") + entry);
          if (isDirectory(directoryPath + "/" + entry)) GetFiles.printFiles(directoryPath + "/" + entry, traversalLevel + 1);
      }
  }
  
  static function main() {
      if (Sys.args().length < 1) return;
      #if cpp
      cpp.vm.Gc.enable(false);
      #end
      
      GetFiles.printFiles(Sys.args()[0]);
      
      #if cpp
      cpp.vm.Gc.enable(true);
      cpp.vm.Gc.run(true);
      #end
  }
}

// Local Variables:
// compile-command: "haxe GetFilesCpp.hxml"
// End:


