package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Contact extends Object
{

	public function getFixtures() : ContactGetFixturesResult;

	public function getFriction() : Float;

	public function getNormal() : ContactGetNormalResult;

	public function getPositions() : ContactGetPositionsResult;

	public function getRestitution() : Float;

	public function isEnabled() : Bool;

	public function isTouching() : Bool;

	public function resetFriction() : Void;

	public function resetRestitution() : Void;

	public function setEnabled(enabled:Bool) : Void;

	public function setFriction(friction:Float) : Void;

	public function setRestitution(restitution:Float) : Void;
}

@:multiReturn
extern class ContactGetPositionsResult
{
	var x1 : Float;
	var y1 : Float;
	var x2 : Float;
	var y2 : Float;
}

@:multiReturn
extern class ContactGetFixturesResult
{
	var fixtureA : Fixture;
	var fixtureB : Fixture;
}

@:multiReturn
extern class ContactGetNormalResult
{
	var nx : Float;
	var ny : Float;
}