package love.thread;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Thread extends Object
{

	public function getError() : String;

	@:overload(function (arg1:Dynamic, arg2:Dynamic, args:Rest<Dynamic>) : Void {})
	public function start() : Void;

	public function wait() : Void;

	public function isRunning() : Bool;
}