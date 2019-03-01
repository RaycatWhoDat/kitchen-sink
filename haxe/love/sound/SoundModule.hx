package love.sound;
import love.Data;
import love.filesystem.File;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.sound")
extern class SoundModule
{

	@:overload(function (filename:String, ?buffer:Float) : Decoder {})
	public static function newDecoder(file:File, ?buffer:Float) : Decoder;

	@:overload(function (file:File) : SoundData {})
	@:overload(function (data:Data) : SoundData {})
	@:overload(function (samples:Float, ?rate:Float, ?bits:Float, ?channels:Float) : SoundData {})
	public static function newSoundData(filename:String) : SoundData;
}