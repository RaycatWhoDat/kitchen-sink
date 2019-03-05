package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Joint extends Object
{

	public function destroy() : Void;

	public function getAnchors() : JointGetAnchorsResult;

	public function getBodies() : JointGetBodiesResult;

	public function getCollideConnected() : Bool;

	public function getReactionForce() : JointGetReactionForceResult;

	public function getReactionTorque(invdt:Float) : Float;

	public function getType() : JointType;

	public function getUserData() : Dynamic;

	public function isDestroyed() : Bool;

	public function setUserData(value:Dynamic) : Void;
}

@:multiReturn
extern class JointGetBodiesResult
{
	var bodyA : Body;
	var bodyB : Body;
}

@:multiReturn
extern class JointGetReactionForceResult
{
	var x : Float;
	var y : Float;
}

@:multiReturn
extern class JointGetAnchorsResult
{
	var x1 : Float;
	var y1 : Float;
	var x2 : Float;
	var y2 : Float;
}