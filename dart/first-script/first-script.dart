import "dart:io";

void main() {
  stdout.writeln("Hello, Dart!");
  String input = stdin.readLineSync();
  stdout.writeln("That's interesting! ($input)");
}
