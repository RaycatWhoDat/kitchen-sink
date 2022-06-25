package;

using StringTools;

function main() {
  Sys.print("".lpad(" ", 4));
  
  var numbers = [];
  for (number in 0...13) {
    Sys.print('$number'.lpad(" ", 4));
    numbers.push(number);
  };

  Sys.println("");
      
  for (number1 in numbers) {
    Sys.print('$number1'.lpad(" ", 4));
    
    for (number2 in numbers) {
      Sys.print('${number1 * number2}'.lpad(" ", 4));
    }

    Sys.println("");
  }
}