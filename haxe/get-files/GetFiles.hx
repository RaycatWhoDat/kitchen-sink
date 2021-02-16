import sys.FileSystem.readDirectory;
import sys.FileSystem.isDirectory;

function printFiles(directoryPath = "..", traversalLevel = 0) {
  var TWO_SPACES = 2;
  var ignoredPaths = [".git", "node_modules", "target", "love", "dist", "build", "_build", ".dub"];

  for (entry in readDirectory(directoryPath)) {
    var spaces = new StringBuf();
    for (index in 0...(traversalLevel * TWO_SPACES)) spaces.add(" ");
    Sys.println(spaces.toString() + entry);
    if (ignoredPaths.indexOf(entry) > -1) continue;
    if (isDirectory(directoryPath + "/" + entry)) {
      printFiles(directoryPath + "/" + entry, traversalLevel + 1);
    }
  }
}

function main() {
  if (Sys.args().length < 1) return;
  GetFiles.printFiles(Sys.args()[0]);
}

// Local Variables:
// compile-command: "haxe GetFilesCpp.hxml"
// End:
