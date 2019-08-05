import std.stdio;
import vibe.d;

void main() {
  writeln("Starting server.");

  auto settings = new HTTPServerSettings();
  settings.port = 8080;
  
  listenHTTP(settings, (req, res) {
      res.writeBody("Hello Vibe.d: " ~ req.path);
  });
  runApplication();
}
