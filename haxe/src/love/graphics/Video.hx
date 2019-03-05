package love.graphics;
import love.audio.Source;
import love.video.VideoStream;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Video extends Drawable
{

	public function getDimensions() : VideoGetDimensionsResult;

	public function getFilter() : VideoGetFilterResult;

	public function getHeight() : Float;

	public function getSource() : Source;

	public function getStream() : VideoStream;

	public function getWidth() : Float;

	public function isPlaying() : Bool;

	public function pause() : Void;

	public function play() : Void;

	public function rewind() : Void;

	public function seek(offset:Float) : Void;

	public function setFilter(min:FilterMode, mag:FilterMode, ?anisotropy:Float) : Void;

	public function setSource(?source:Source) : Void;

	public function tell(seconds:Float) : Void;
}

@:multiReturn
extern class VideoGetDimensionsResult
{
	var width : Float;
	var height : Float;
}

@:multiReturn
extern class VideoGetFilterResult
{
	var min : FilterMode;
	var mag : FilterMode;
	var anisotropy : Float;
}