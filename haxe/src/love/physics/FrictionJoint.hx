package love.physics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class FrictionJoint extends Joint
{

	public function getMaxForce() : Float;

	public function getMaxTorque() : Float;

	public function setMaxForce(maxForce:Float) : Void;

	public function setMaxTorque(torque:Float) : Void;
}