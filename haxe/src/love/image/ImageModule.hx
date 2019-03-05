package love.image;
import love.filesystem.FileData;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.image")
extern class ImageModule
{

	@:overload(function (fileData:FileData) : Bool {})
	public static function isCompressed(filename:String) : Bool;

	@:overload(function (fileData:FileData) : CompressedImageData {})
	public static function newCompressedData(filename:String) : CompressedImageData;

	@:overload(function (width:Float, height:Float, data:String) : ImageData {})
	@:overload(function (filename:String) : ImageData {})
	@:overload(function (filedata:FileData) : ImageData {})
	public static function newImageData(width:Float, height:Float) : ImageData;
}