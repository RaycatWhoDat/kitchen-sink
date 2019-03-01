package love.touch;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.touch")
extern class TouchModule
{

	public static function getPosition(id:UserData) : TouchModuleGetPositionResult;

	public static function getPressure(id:UserData) : Float;

	public static function getTouches() : Table<Dynamic,Dynamic>;
}

@:multiReturn
extern class TouchModuleGetPositionResult
{
	var x : Float;
	var y : Float;
}