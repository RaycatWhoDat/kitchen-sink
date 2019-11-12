package catalina;

import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
import haxe.macro.Expr;
using haxe.macro.Tools;

@:keep
class AssetManagement {
    public static function copy(srcPath: Path, dstPath: Path) {
        if (!FileSystem.exists(dstPath.toString())) {
            FileSystem.createDirectory(dstPath.toString());
        }
        
        for (entry in FileSystem.readDirectory(srcPath.toString())) {
            var currentPath = new Path(Path.join([srcPath.toString(), entry]));
            var newPath = new Path(Path.join([dstPath.toString(), entry]));
            
            if (FileSystem.isDirectory(currentPath.toString())) {
                AssetManagement.copy(currentPath, newPath);
            } else {
                trace('Found: $currentPath');
                File.copy(currentPath.toString(), newPath.toString());
            }
        }
    }
    
    public static function copyDirectory(srcDirectory: String, dstDirectory: String) {
        var srcPath = new Path(srcDirectory);
        var dstPath = new Path(dstDirectory);
        
        trace('Copying all files in ' + srcPath + ' to ' + dstPath + '...');
        AssetManagement.copy(srcPath, dstPath);
        trace('Done.');
    }
}
