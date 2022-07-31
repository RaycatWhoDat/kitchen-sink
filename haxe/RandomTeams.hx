package;

function main() {
  var names = ["Apple", "Banana", "Cherry", "Date", "Eggplant", "Fig", "Grape", "Herb"];
  var others = [];
  while (others.length < 4) {
    var index = Std.random(names.length); 
    others.push(names.splice(index, 1)[0]);
  }

  for (name in names) trace("Blue: " + name);
  for (name in others) trace("Gold: " + name);
}