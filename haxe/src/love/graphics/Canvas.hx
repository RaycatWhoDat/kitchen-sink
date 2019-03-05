package love.graphics;
import love.image.ImageData;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Canvas extends Texture
{

	public function getDimensions() : CanvasGetDimensionsResult;

	public function getFilter() : CanvasGetFilterResult;

	public function getFormat() : CanvasFormat;

	public function getHeight() : Float;

	public function getMSAA() : Float;

	public function getWidth() : Float;

	public function getWrap() : CanvasGetWrapResult;

	@:overload(function (x:Float, y:Float, width:Float, height:Float) : ImageData {})
	public function newImageData() : ImageData;

	public function renderTo(func:Dynamic) : Void;

	public function setFilter(min:FilterMode, ?mag:FilterMode, ?anisotropy:Float) : Void;

	public function setWrap(horizontal:WrapMode, ?vertical:WrapMode) : Void;
}

@:multiReturn
extern class CanvasGetFilterResult
{
	var min : FilterMode;
	var mag : FilterMode;
	var anisotropy : Float;
}

@:multiReturn
extern class CanvasGetDimensionsResult
{
	var width : Float;
	var height : Float;
}

@:multiReturn
extern class CanvasGetWrapResult
{
	var horizontal : WrapMode;
	var vertical : WrapMode;
}