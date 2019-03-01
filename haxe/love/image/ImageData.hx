package love.image;
import love.filesystem.FileData;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class ImageData extends Data
{

	public function encode(format:ImageFormat, ?filename:String) : FileData;

	public function getDimensions() : ImageDataGetDimensionsResult;

	public function getHeight() : Float;

	public function getPixel(x:Float, y:Float) : ImageDataGetPixelResult;

	public function getWidth() : Float;

	public function mapPixel(pixelFunction:Dynamic) : Void;

	public function paste(source:ImageData, dx:Float, dy:Float, sx:Float, sy:Float, sw:Float, sh:Float) : Void;

	public function setPixel(x:Float, y:Float, r:Float, g:Float, b:Float, a:Float) : Void;
}

@:multiReturn
extern class ImageDataGetPixelResult
{
	var r : Float;
	var g : Float;
	var b : Float;
	var a : Float;
}

@:multiReturn
extern class ImageDataGetDimensionsResult
{
	var width : Float;
	var height : Float;
}