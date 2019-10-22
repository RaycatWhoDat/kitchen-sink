package;

class RangeTools {
    public static function range(min = 0, max = 1) {
        return [for (_ in min...(max + 1)) _];
    }
}
