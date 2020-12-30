package;

typedef ConfigData = { var prefix: String; var token: String; };

class Config {
  macro public static function load() {
    var path = "config.json";
    var value = sys.io.File.getContent(path);
    var json = haxe.Json.parse(value);
    
    return macro $v{json};
  }
}