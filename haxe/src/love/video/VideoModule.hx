package love.video;
import love.filesystem.File;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.video")
extern class VideoModule
{

	@:overload(function (file:File) : VideoStream {})
	public static function newVideoStream(filename:String) : VideoStream;
}