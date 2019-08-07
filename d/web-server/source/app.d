import std.stdio;
import vibe.d;

void mainHandler(HTTPServerRequest req, HTTPServerResponse res) {
  res.writeBody("Hello: " ~ req.path);
}

void main() {
  writeln("Starting server.");

  auto settings = new HTTPServerSettings();
  settings.port = 8080;
  
  listenHTTP(settings, &mainHandler);
  runApplication();
}

// Local Variables:
// compile-command: "cd .. && dub run"
// End:
