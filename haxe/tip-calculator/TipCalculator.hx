package;

function main() {
  Sys.println("What's the bill amount?");

  var billAmount = null;
  while (billAmount == null) {
    var input = Sys.stdin().readLine();
    billAmount = try { Std.parseFloat(input); } catch (error) { null; };
    billAmount = try { Std.parseInt(input); } catch (error) { null; };
    if (billAmount != null) break;
    trace('Please enter a valid number.');
  }

  trace(billAmount);
}
