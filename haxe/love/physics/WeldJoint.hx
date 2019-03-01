package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class WeldJoint extends Joint
{

	public function getDampingRatio() : Float;

	public function getFrequency() : Float;

	public function setDampingRatio(ratio:Float) : Void;

	public function setFrequency(freq:Float) : Void;
}