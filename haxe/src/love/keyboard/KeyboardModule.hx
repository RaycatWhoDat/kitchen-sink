package love.keyboard;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.keyboard")
extern class KeyboardModule
{

	public static function getKeyFromScancode(scancode:String) : String;

	public static function getScancodeFromKey(key:String) : String;

	public static function hasKeyRepeat() : Bool;

	public static function hasTextInput() : Bool;

	@:overload(function (key:String, args:Rest<String>) : Bool {})
	public static function isDown(key:String) : Bool;

	public static function isScancodeDown(scancode:String, args:Rest<String>) : Bool;

	public static function setKeyRepeat(enable:Bool) : Void;

	@:overload(function (enable:Bool, x:Float, y:Float, w:Float, h:Float) : Void {})
	public static function setTextInput(enable:Bool) : Void;
}