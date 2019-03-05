package love.image;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class CompressedImageData extends Data
{

	@:overload(function (level:Float) : CompressedImageDataGetDimensionsResult {})
	public function getDimensions() : CompressedImageDataGetDimensionsResult;

	public function getFormat() : CompressedImageFormat;

	@:overload(function (level:Float) : Float {})
	public function getHeight() : Float;

	public function getMipmapCount(mipmaps:Float) : Void;

	@:overload(function (level:Float) : Float {})
	public function getWidth() : Float;
}

@:multiReturn
extern class CompressedImageDataGetDimensionsResult
{
	var width : Float;
	var height : Float;
}