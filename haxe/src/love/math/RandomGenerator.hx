package love.math;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class RandomGenerator extends Object
{

	public function getSeed() : RandomGeneratorGetSeedResult;

	public function getState() : String;

	@:overload(function (max:Float) : Float {})
	@:overload(function (min:Float, max:Float) : Float {})
	public function random() : Float;

	public function randomNormal(?stddev:Float, ?mean:Float) : Float;

	@:overload(function (low:Float, ?high:Float) : Void {})
	public function setSeed(seed:Float) : Void;

	public function setState(state:String) : Void;
}

@:multiReturn
extern class RandomGeneratorGetSeedResult
{
	var low : Float;
	var high : Float;
}