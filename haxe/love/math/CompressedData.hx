package love.math;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class CompressedData extends Data
{

	public function getFormat() : CompressedDataFormat;
}