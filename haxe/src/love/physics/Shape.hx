package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Shape extends Object
{

	public function computeAABB(tx:Float, ty:Float, tr:Float, ?childIndex:Float) : ShapeComputeAABBResult;

	public function computeMass(density:Float) : ShapeComputeMassResult;

	public function getChildCount() : Float;

	public function getRadius() : Float;

	public function getType() : ShapeType;

	public function rayCast(x1:Float, y1:Float, x2:Float, y2:Float, maxFraction:Float, tx:Float, ty:Float, tr:Float, ?childIndex:Float) : ShapeRayCastResult;

	public function testPoint(x:Float, y:Float) : Bool;
}

@:multiReturn
extern class ShapeComputeMassResult
{
	var x : Float;
	var y : Float;
	var mass : Float;
	var inertia : Float;
}

@:multiReturn
extern class ShapeComputeAABBResult
{
	var topLeftX : Float;
	var topLeftY : Float;
	var bottomRightX : Float;
	var bottomRightY : Float;
}

@:multiReturn
extern class ShapeRayCastResult
{
	var xn : Float;
	var yn : Float;
	var fraction : Float;
}