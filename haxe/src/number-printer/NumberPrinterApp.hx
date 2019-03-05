// Number Printing
using Lambda;

class NumberPrinter {
  private var arrayOfNumbers: Array<Int> = null;
  
  public function new() {
    trace("New number printer created.");
    var maximumNumber = 0;
    var maxFlag = Sys.args().indexOf("--max");
    if (maxFlag > -1) maximumNumber = Std.parseInt(Sys.args()[maxFlag + 1]);
    
    arrayOfNumbers = [for (i in 0...{ maximumNumber + 1; }) i];
  }

  public function printNumbers() {
    arrayOfNumbers.iter(function (number) trace(number));
  }
}

class NumberPrinterApp {
  public static function main() {
    var numberPrinter = new NumberPrinter();
    
    numberPrinter.printNumbers();
  }
}