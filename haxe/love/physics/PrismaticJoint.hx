package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class PrismaticJoint extends Joint
{

	public function getAxis() : PrismaticJointGetAxisResult;

	public function getJointSpeed() : Float;

	public function getJointTranslation() : Float;

	public function getLimits() : PrismaticJointGetLimitsResult;

	public function getLowerLimit() : Float;

	public function getMaxMotorForce() : Float;

	public function getMotorForce() : Float;

	public function getMotorSpeed() : Float;

	public function getUpperLimit() : Float;

	public function hasLimitsEnabled() : Bool;

	public function isMotorEnabled() : Bool;

	public function setLimits(lower:Float, upper:Float) : Void;

	public function setLimitsEnabled(enable:Bool) : Void;

	public function setLowerLimit(lower:Float) : Void;

	public function setMaxMotorForce(f:Float) : Void;

	public function setMotorEnabled(enable:Bool) : Void;

	public function setMotorSpeed(s:Float) : Void;

	public function setUpperLimit(upper:Float) : Void;
}

@:multiReturn
extern class PrismaticJointGetLimitsResult
{
	var lower : Float;
	var upper : Float;
}

@:multiReturn
extern class PrismaticJointGetAxisResult
{
	var x : Float;
	var y : Float;
}