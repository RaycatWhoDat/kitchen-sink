package;

class EightyBinary {
  public static function main() {
    var mapping = ["01010101", "11010010", "10101010" ]
                  .map(rawData -> rawData.split("").map(number -> number == "1" ? "true" : "false"));

    trace(mapping);
  }
}
