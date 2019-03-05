package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class MouseJoint extends Joint
{

	public function getDampingRatio() : Float;

	public function getFrequency() : Float;

	public function getMaxForce() : Float;

	public function getTarget() : MouseJointGetTargetResult;

	public function setDampingRatio(ratio:Float) : Void;

	public function setFrequency(freq:Float) : Void;

	public function setMaxForce(f:Float) : Void;

	public function setTarget(x:Float, y:Float) : Void;
}

@:multiReturn
extern class MouseJointGetTargetResult
{
	var x : Float;
	var y : Float;
}