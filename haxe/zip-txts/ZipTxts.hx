package;

// Requires Haxe 4.2.0

import sys.io.File;

@:tink class ZipTxts {
  static function main() {
    var firstNames = File.getContent("first_names.txt").split("\n");
    var lastNames = File.getContent("last_names.txt").split("\n");
    var emails = File.getContent("emails.txt").split("\n");
    var dobs = File.getContent("dobs.txt").split("\n");

    var output = File.write("final_conversion.csv");

    for([firstName in firstNames,
         lastName in lastNames,
         email in emails,
         dob in dobs]) {
      output.writeString('$firstName|$lastName|$email|$dob\n');
    }
  }
}