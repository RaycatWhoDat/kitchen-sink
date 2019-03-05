package love;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Data extends Object
{

	public function getPointer() : UserData;

	public function getSize() : Float;

	public function getString() : String;
}