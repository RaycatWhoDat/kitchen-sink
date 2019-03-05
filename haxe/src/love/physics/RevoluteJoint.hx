package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class RevoluteJoint extends Joint
{

	public function setLimitsEnabled(enable:Bool) : Void;

	public function setMotorEnabled(enable:Bool) : Void;

	public function getJointAngle() : Float;

	public function getJointSpeed() : Float;

	public function getLimits() : RevoluteJointGetLimitsResult;

	public function getLowerLimit() : Float;

	public function getMaxMotorTorque() : Float;

	public function getMotorSpeed() : Float;

	public function getMotorTorque() : Float;

	public function getUpperLimit() : Float;

	public function hasLimitsEnabled() : Bool;

	public function isMotorEnabled() : Bool;

	public function setLimits(lower:Float, upper:Float) : Void;

	public function setLowerLimit(lower:Float) : Void;

	public function setMaxMotorTorque(f:Float) : Void;

	public function setMotorSpeed(s:Float) : Void;

	public function setUpperLimit(upper:Float) : Void;
}

@:multiReturn
extern class RevoluteJointGetLimitsResult
{
	var lower : Float;
	var upper : Float;
}