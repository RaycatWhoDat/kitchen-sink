package;

using Lambda;

import unixtools.*;

class SummaryCombinator {
  public static function main() {
    var allFilePaths = Find.recursiveFind('.',~/_summary/);
    var destinationDirectory = "combined-summaries/";
    
    if (sys.FileSystem.exists(destinationDirectory)) Sys.command('rm -rf ${destinationDirectory}');
    sys.FileSystem.createDirectory(destinationDirectory);

    for (filePath in allFilePaths) {
      var newFilePath = new haxe.io.Path(~/_summary/m.replace(~/ /g.replace(filePath, "_"), "_combined"));
      var matchingDestination = '${destinationDirectory}/${newFilePath.file}.${newFilePath.ext}';

      Sys.println('>>> ${filePath}');

      function splitShiftJoin(_sourceFile: String) {
        var newSourceFile = _sourceFile.split("\n");
        newSourceFile.shift();
        return newSourceFile.join("\n");
      }
      
      Cat.copyOrAppend([filePath], matchingDestination, splitShiftJoin);
    }
  }
}