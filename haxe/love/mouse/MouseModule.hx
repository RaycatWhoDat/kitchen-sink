package love.mouse;
import love.filesystem.FileData;
import love.image.ImageData;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.mouse")
extern class MouseModule
{

	public static function getCursor() : Cursor;

	public static function getPosition() : MouseModuleGetPositionResult;

	public static function getRelativeMode() : Bool;

	public static function getSystemCursor(ctype:CursorType) : Cursor;

	public static function getX() : Float;

	public static function getY() : Float;

	public static function hasCursor() : Bool;

	public static function isDown(button:Float, args:Rest<Float>) : Bool;

	public static function isGrabbed() : Bool;

	public static function isVisible() : Bool;

	@:overload(function (filepath:String, ?hotx:Float, ?hoty:Float) : Cursor {})
	@:overload(function (fileData:FileData, ?hotx:Float, ?hoty:Float) : Cursor {})
	public static function newCursor(imageData:ImageData, ?hotx:Float, ?hoty:Float) : Cursor;

	@:overload(function (cursor:Cursor) : Void {})
	public static function setCursor() : Void;

	public static function setGrabbed(grab:Bool) : Void;

	public static function setPosition(x:Float, y:Float) : Void;

	public static function setRelativeMode(enable:Bool) : Void;

	public static function setVisible(visible:Bool) : Void;

	public static function setX(x:Float) : Void;

	public static function setY(y:Float) : Void;
}

@:multiReturn
extern class MouseModuleGetPositionResult
{
	var x : Float;
	var y : Float;
}