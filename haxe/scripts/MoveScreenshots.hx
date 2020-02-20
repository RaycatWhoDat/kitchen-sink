import sys.FileSystem.*;

class MoveScreenshots {
  public static function main() {
    var screenshotDestination = "Work/_Screenshots/";
    var oldPath = Sys.getCwd();
    var desktopPath = Sys.programPath().split("Desktop")[0] + "Desktop";

    Sys.setCwd(desktopPath);

    trace("Moving screenshots...");
    for (filename in readDirectory(Sys.getCwd())) {
      if (filename.indexOf("Screen Shot") < 0) continue;
      rename(filename, screenshotDestination + filename);
    };
    trace("Done.");

    Sys.setCwd(oldPath);
  }
}
// Local Variables:
// compile-command: "haxe --main MoveScreenshots --interp"
// End:
