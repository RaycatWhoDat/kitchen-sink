package love.graphics;
@:enum
abstract StencilAction (String)
{
	var Replace = "replace";
	var Increment = "increment";
	var Decrement = "decrement";
	var Incrementwrap = "incrementwrap";
	var Decrementwrap = "decrementwrap";
	var Invert = "invert";
}