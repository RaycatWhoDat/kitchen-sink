package;

// Requires Haxe 4.2.0

import sys.io.File;

function main() {
  var numbers = File.read("formatted_numbers.txt");
  var texts = File.read("formatted_text.txt");
  var types = File.read("formatted_types.txt");

  var output = File.write("final_conversion.csv");

  while (!numbers.eof()) {
    var number = try { numbers.readLine(); } catch (e) { ""; };
    var text = try { texts.readLine(); } catch (e) { ""; };
    var type = try { types.readLine(); } catch (e) { ""; };

    output.writeString('$number|$text|$type\n');
  }

  output.close();
}