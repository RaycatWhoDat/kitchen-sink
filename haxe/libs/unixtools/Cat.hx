package unixtools;

using Lambda;

import haxe.io.Path;

class Cat {
  public static function copyOrAppend(sources: Array<String>, destination: String, ?fileOperation) {
    for (source in sources) {
      if (!sys.FileSystem.exists(destination)) {
        sys.io.File.copy(source, destination);
      } else {
        var sourceFile = sys.io.File.getContent(source);
        var destinationFile = sys.io.File.append(destination);

        var _sourceFile = fileOperation != null ? fileOperation(sourceFile) : sourceFile;
        
        destinationFile.writeString(_sourceFile);
        destinationFile.flush();
        destinationFile.close();
      }
    }
  }
}