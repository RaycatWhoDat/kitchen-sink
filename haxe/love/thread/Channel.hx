package love.thread;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Channel extends Object
{

	public function clear() : Void;

	public function demand() : Dynamic;

	public function getCount() : Float;

	public function peek() : Dynamic;

	public function performAtomic(func:Dynamic, arg1:Dynamic, args:Rest<Dynamic>) : ChannelPerformAtomicResult;

	public function pop() : Dynamic;

	public function push(value:Dynamic) : Void;

	public function supply(value:Dynamic) : Void;
}

@:multiReturn
extern class ChannelPerformAtomicResult
{
	var ret1 : Dynamic;
}