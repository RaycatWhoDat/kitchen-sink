package love.audio;
@:enum
abstract DistanceModel (String)
{
	var None = "none";
	var Inverse = "inverse";
	var Inverseclamped = "inverseclamped";
	var Linear = "linear";
	var Linearclamped = "linearclamped";
	var Exponent = "exponent";
	var Exponentclamped = "exponentclamped";
}