package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class PolygonShape extends Shape
{

	public function getPoints() : PolygonShapeGetPointsResult;
}

@:multiReturn
extern class PolygonShapeGetPointsResult
{
	var x1 : Float;
	var y1 : Float;
	var x2 : Float;
	var y2 : Float;
}