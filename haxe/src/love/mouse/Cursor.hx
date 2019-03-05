package love.mouse;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Cursor extends Object
{

	public function getType() : CursorType;
}