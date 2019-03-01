package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class ChainShape extends Shape
{

	public function getChildEdge(index:Float) : Float;

	public function getNextVertex(?x:Float, ?y:Float) : Void;

	public function getPoint(index:Float) : ChainShapeGetPointResult;

	public function getPoints() : ChainShapeGetPointsResult;

	public function getPreviousVertex() : ChainShapeGetPreviousVertexResult;

	public function getVertexCount() : Float;

	public function setNextVertex(x:Float, y:Float) : Void;

	public function setPreviousVertex(x:Float, y:Float) : Void;
}

@:multiReturn
extern class ChainShapeGetPointsResult
{
	var x1 : Float;
	var y1 : Float;
	var x2 : Float;
	var y2 : Float;
}

@:multiReturn
extern class ChainShapeGetPointResult
{
	var x : Float;
	var y : Float;
}

@:multiReturn
extern class ChainShapeGetPreviousVertexResult
{
	var x : Float;
	var y : Float;
}