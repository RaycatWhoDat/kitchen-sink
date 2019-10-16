import haxe.extern.EitherType;

@:jsRequire("lodash")
extern class Lodash {
    static function get(object: Dynamic, path: EitherType<String, Array<String>>, defaultValue: Dynamic): Dynamic;
    static function round(number: Float, ?precision: Int = 0): Float;
}
