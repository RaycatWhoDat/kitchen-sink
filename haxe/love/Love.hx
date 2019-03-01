package love;
import love.filesystem.File;
import love.joystick.GamepadAxis;
import love.joystick.GamepadButton;
import love.joystick.Joystick;
import love.joystick.JoystickHat;
import love.thread.Thread;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love")
extern class Love
{

	public static function getVersion() : LoveGetVersionResult;
	public static var conf : Table<Dynamic,Dynamic>->Void;
	public static var directorydropped : String->Void;
	public static var draw : Void->Void;
	public static var errhand : String->Void;
	public static var filedropped : File->Void;
	public static var focus : Bool->Void;
	public static var gamepadaxis : Joystick->GamepadAxis->Void;
	public static var gamepadpressed : Joystick->GamepadButton->Void;
	public static var gamepadreleased : Joystick->GamepadButton->Void;
	public static var joystickadded : Joystick->Void;
	public static var joystickaxis : Joystick->Float->Float->Void;
	public static var joystickhat : Joystick->Float->JoystickHat->Void;
	public static var joystickpressed : Float->Float->Void;
	public static var joystickreleased : Float->Float->Void;
	public static var joystickremoved : Joystick->Void;
	public static var keypressed : String->String->Bool->Void;
	public static var keyreleased : String->Void;
	public static var load : Table<Dynamic,Dynamic>->Void;
	public static var lowmemory : Void->Void;
	public static var mousefocus : Bool->Void;
	public static var mousemoved : Float->Float->Float->Float->Bool->Void;
	public static var mousepressed : Float->Float->Float->Bool->Void;
	public static var mousereleased : Float->Float->Float->Bool->Void;
	public static var quit : Void->Bool;
	public static var resize : Float->Float->Void;
	public static var run : Void->Void;
	public static var textedited : String->Float->Float->Void;
	public static var textinput : String->Void;
	public static var threaderror : Thread->String->Void;
	public static var touchmoved : UserData->Float->Float->Float->Float->Float->Void;
	public static var touchpressed : UserData->Float->Float->Float->Float->Float->Void;
	public static var touchreleased : UserData->Float->Float->Float->Float->Float->Void;
	public static var update : Float->Void;
	public static var visible : Bool->Void;
	public static var wheelmoved : Float->Float->Void;
}

@:multiReturn
extern class LoveGetVersionResult
{
	var major : Float;
	var minor : Float;
	var revision : Float;
	var codename : String;
}