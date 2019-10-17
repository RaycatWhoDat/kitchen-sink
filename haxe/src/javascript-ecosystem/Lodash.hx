import haxe.extern.EitherType;

#if server
@:jsRequire("lodash")
#end
@:native("_")
extern class Lodash {
    static function get(object: Dynamic, path: EitherType<String, Array<String>>, defaultValue: Dynamic): Dynamic;
    static function round(number: Float, ?precision: Int = 0): Float;
}
