package;

import sys.io.*;

function main() {
  var count = 0;
  var file = File.getContent("../awk/test-text.txt");
  ~/(TXR)/g.map(file, match -> {
      count++;
      return match.matched(0);
    });

  trace("Number of TXR occurrences: " + count);
}