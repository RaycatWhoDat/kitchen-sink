package love.filesystem;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class FileData extends Data
{

	public function getExtension() : String;

	public function getFilename() : String;
}