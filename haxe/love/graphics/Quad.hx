package love.graphics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Quad extends Object
{

	public function getTextureDimensions() : QuadGetTextureDimensionsResult;

	public function getViewport() : QuadGetViewportResult;

	public function setViewport() : QuadSetViewportResult;
}

@:multiReturn
extern class QuadGetViewportResult
{
	var x : Float;
	var y : Float;
	var w : Float;
	var h : Float;
}

@:multiReturn
extern class QuadSetViewportResult
{
	var x : Float;
	var y : Float;
	var w : Float;
	var h : Float;
}

@:multiReturn
extern class QuadGetTextureDimensionsResult
{
	var sw : Float;
	var sh : Float;
}