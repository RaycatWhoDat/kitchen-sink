package love.sound;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class SoundData extends Data
{

	public function getBitDepth() : Float;

	public function getChannels() : Float;

	public function getDuration() : Float;

	public function getSample(i:Float) : Float;

	public function getSampleCount() : Float;

	public function getSampleRate() : Float;

	public function setSample(i:Float, sample:Float) : Void;
}