package love.sound;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Decoder extends Object
{

	public function getBitDepth() : Float;

	public function getChannels() : Float;

	public function getDuration() : Float;

	public function getSampleRate() : Float;
}