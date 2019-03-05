package love.timer;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.timer")
extern class TimerModule
{

	public static function getAverageDelta() : Float;

	public static function getDelta() : Float;

	public static function getFPS() : Float;

	public static function getTime() : Float;

	public static function sleep(s:Float) : Void;

	public static function step() : Void;
}