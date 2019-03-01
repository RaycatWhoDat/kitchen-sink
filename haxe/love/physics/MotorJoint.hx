package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class MotorJoint extends Joint
{

	public function getAngularOffset() : Float;

	public function getLinearOffset() : MotorJointGetLinearOffsetResult;

	public function setAngularOffset(angularoffset:Float) : Void;

	public function setLinearOffset(x:Float, y:Float) : Void;
}

@:multiReturn
extern class MotorJointGetLinearOffsetResult
{
	var x : Float;
	var y : Float;
}