package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class GearJoint extends Joint
{

	public function getJoints() : GearJointGetJointsResult;

	public function getRatio() : Float;

	public function setRatio(ratio:Float) : Void;
}

@:multiReturn
extern class GearJointGetJointsResult
{
	var joint1 : Joint;
	var joint2 : Joint;
}