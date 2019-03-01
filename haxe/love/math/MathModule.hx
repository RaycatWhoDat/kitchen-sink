package love.math;
import love.Data;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.math")
extern class MathModule
{

	@:overload(function (data:Data, ?format:CompressedDataFormat, ?level:Float) : CompressedData {})
	public static function compress(rawstring:String, ?format:CompressedDataFormat, ?level:Float) : CompressedData;

	@:overload(function (compressedString:String, format:CompressedDataFormat) : String {})
	@:overload(function (data:Data, format:CompressedDataFormat) : String {})
	public static function decompress(compressedData:CompressedData) : String;

	@:overload(function (color:Table<Dynamic,Dynamic>) : MathModuleGammaToLinearResult {})
	@:overload(function (c:Float) : Float {})
	public static function gammaToLinear(r:Float, g:Float, b:Float) : MathModuleGammaToLinearResult;

	public static function getRandomSeed() : MathModuleGetRandomSeedResult;

	public static function getRandomState() : String;

	@:overload(function (x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, args:Rest<Float>) : Bool {})
	public static function isConvex(vertices:Table<Dynamic,Dynamic>) : Bool;

	@:overload(function (color:Table<Dynamic,Dynamic>) : MathModuleLinearToGammaResult {})
	@:overload(function (lc:Float) : Float {})
	public static function linearToGamma(lr:Float, lg:Float, lb:Float) : MathModuleLinearToGammaResult;

	@:overload(function (x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, args:Rest<Float>) : BezierCurve {})
	public static function newBezierCurve(vertices:Table<Dynamic,Dynamic>) : BezierCurve;

	@:overload(function (low:Float, ?high:Float) : RandomGenerator {})
	@:overload(function (seed:String) : RandomGenerator {})
	public static function newRandomGenerator() : RandomGenerator;

	@:overload(function (x:Float, y:Float) : Float {})
	@:overload(function (x:Float, y:Float, z:Float) : Float {})
	@:overload(function (x:Float, y:Float, z:Float, w:Float) : Float {})
	public static function noise(x:Float) : Float;

	@:overload(function (max:Float) : Float {})
	@:overload(function (min:Float, max:Float) : Float {})
	public static function random() : Float;

	public static function randomNormal(?stddev:Float, ?mean:Float) : Float;

	@:overload(function (low:Float, ?high:Float) : Void {})
	public static function setRandomSeed(seed:Float) : Void;

	public static function setRandomState(state:String) : Void;

	@:overload(function (x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, args:Rest<Float>) : Table<Dynamic,Dynamic> {})
	public static function triangulate(polygon:Table<Dynamic,Dynamic>) : Table<Dynamic,Dynamic>;
}

@:multiReturn
extern class MathModuleLinearToGammaResult
{
	var cr : Float;
	var cg : Float;
	var cb : Float;
}

@:multiReturn
extern class MathModuleGetRandomSeedResult
{
	var low : Float;
	var high : Float;
}

@:multiReturn
extern class MathModuleGammaToLinearResult
{
	var lr : Float;
	var lg : Float;
	var lb : Float;
}