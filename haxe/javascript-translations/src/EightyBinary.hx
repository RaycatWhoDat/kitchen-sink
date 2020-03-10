package;

using Lambda;

class EightyBinary {
    public static function run() {
        var mapping = "010101011101001010101010"
            .split("")
            .mapi((index, number) -> {
                '${number == "1"}';
            }).join("");

        trace(mapping);
    }
}
