package;

function main() {
  var choices = [-1, 0, 1];
  var ratios = ["-1" => 0, "0" => 0, "1" => 0];
  for (number in 0...100) {
    var choice = choices[Math.floor(Math.random() * choices.length)];
    ratios.set('$choice', ratios.get('$choice') + 1);
  };

  for (key => value in ratios) {
    Sys.println('$key: ' + (value / 100));
  }
}