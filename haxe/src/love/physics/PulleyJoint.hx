package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class PulleyJoint extends Joint
{

	public function getConstant() : Float;

	public function getGroundAnchors() : PulleyJointGetGroundAnchorsResult;

	public function getLengthA() : Float;

	public function getLengthB() : Float;

	public function getMaxLengths() : PulleyJointGetMaxLengthsResult;

	public function getRatio() : Float;

	public function setConstant(length:Float) : Void;

	public function setMaxLengths(max1:Float, max2:Float) : Void;

	public function setRatio(ratio:Float) : Void;
}

@:multiReturn
extern class PulleyJointGetGroundAnchorsResult
{
	var a1x : Float;
	var a1y : Float;
	var a2x : Float;
	var a2y : Float;
}

@:multiReturn
extern class PulleyJointGetMaxLengthsResult
{
	var len1 : Float;
	var len2 : Float;
}