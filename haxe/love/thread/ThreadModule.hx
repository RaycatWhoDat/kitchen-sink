package love.thread;
import love.filesystem.FileData;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.thread")
extern class ThreadModule
{

	public static function getChannel(name:String) : Channel;

	public static function newChannel() : Channel;

	@:overload(function (fileData:FileData) : Thread {})
	@:overload(function (codestring:String) : Thread {})
	public static function newThread(filename:String) : Thread;
}