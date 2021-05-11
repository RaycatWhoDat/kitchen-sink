void main() {
  import std.stdio: writeln, writefln;
  import std.range: iota, cycle, take, zip;
  import std.algorithm: each, map;

  struct RandomItem {
    string name;
    int order;
  }
  
  auto numbers = iota(1, 6);
  numbers.cycle.take(20).each!(writeln);

  auto fruits = ["Apple", "Banana", "Cherry", "Date", "Fig"];
  fruits.cycle.take(20).each!(writeln);

  zip(fruits, numbers)
    .map!(item => RandomItem(item[0], item[1]))
    .cycle
    .take(20)
    .each!(item => "%s: %s".writefln(item.name, item.order));
}
