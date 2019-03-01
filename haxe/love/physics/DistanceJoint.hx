package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class DistanceJoint extends Joint
{

	public function getDampingRatio() : Float;

	public function getFrequency() : Float;

	public function getLength() : Float;

	public function setDampingRatio(ratio:Float) : Void;

	public function setFrequency(Hz:Float) : Void;

	public function setLength(l:Float) : Void;
}