package love.graphics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Text extends Drawable
{

	@:overload(function (coloredtext:Table<Dynamic,Dynamic>, x:Float, y:Float, ?angle:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Float {})
	public function add(textstring:String, x:Float, y:Float, ?angle:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Float;

	@:overload(function (coloredtext:Table<Dynamic,Dynamic>, wraplimit:Float, align:AlignMode, x:Float, y:Float, ?angle:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Float {})
	public function addf(textstring:String, wraplimit:Float, align:AlignMode, x:Float, y:Float, ?angle:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Float;

	public function clear() : Void;

	@:overload(function (index:Float) : TextGetDimensionsResult {})
	public function getDimensions() : TextGetDimensionsResult;

	public function getFont() : Font;

	@:overload(function (index:Float) : Float {})
	public function getHeight() : Float;

	@:overload(function (index:Float) : Float {})
	public function getWidth() : Float;

	@:overload(function (coloredtext:Table<Dynamic,Dynamic>) : Void {})
	@:overload(function () : Void {})
	public function set(textstring:String) : Void;

	@:overload(function (coloredtext:Table<Dynamic,Dynamic>, wraplimit:Float, ?align:AlignMode) : Void {})
	@:overload(function () : Void {})
	public function setf(textstring:String, wraplimit:Float, ?align:AlignMode) : Void;

	public function setFont(font:Font) : Void;
}

@:multiReturn
extern class TextGetDimensionsResult
{
	var width : Float;
	var height : Float;
}