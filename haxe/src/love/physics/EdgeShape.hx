package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class EdgeShape extends Shape
{

	public function getPoints() : EdgeShapeGetPointsResult;

	public function getNextVertex() : EdgeShapeGetNextVertexResult;

	public function getPreviousVertex() : EdgeShapeGetPreviousVertexResult;

	public function setNextVertex(x:Float, y:Float) : Void;

	public function setPreviousVertex(x:Float, y:Float) : Void;
}

@:multiReturn
extern class EdgeShapeGetPointsResult
{
	var x1 : Float;
	var y1 : Float;
	var x2 : Float;
	var y2 : Float;
}

@:multiReturn
extern class EdgeShapeGetPreviousVertexResult
{
	var x : Float;
	var y : Float;
}

@:multiReturn
extern class EdgeShapeGetNextVertexResult
{
	var x : Float;
	var y : Float;
}