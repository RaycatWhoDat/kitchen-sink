package;

class Application {
  public static function main() {
    var express = js.Lib.require("express");
    var server = express();
    server.get("/", function (req, res) { res.send("This is a test."); });
    server.listen(8080, function (req, res) { trace("Running."); });
  }
}