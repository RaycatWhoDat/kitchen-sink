package love.system;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.system")
extern class SystemModule
{

	public static function getClipboardText() : String;

	public static function getOS() : String;

	public static function getPowerInfo() : SystemModuleGetPowerInfoResult;

	public static function getProcessorCount() : Float;

	public static function openURL(url:String) : Bool;

	public static function setClipboardText(text:String) : Void;

	public static function vibrate(?seconds:Float) : Void;
}

@:multiReturn
extern class SystemModuleGetPowerInfoResult
{
	var state : PowerState;
	var percent : Float;
	var seconds : Float;
}