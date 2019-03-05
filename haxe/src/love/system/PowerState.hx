package love.system;
@:enum
abstract PowerState (String)
{
	var Unknown = "unknown";
	var Battery = "battery";
	var Nobattery = "nobattery";
	var Charging = "charging";
	var Charged = "charged";
}