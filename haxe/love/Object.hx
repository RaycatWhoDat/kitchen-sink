package love;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Object extends UserData
{

	public function type() : String;

	public function typeOf(name:String) : Bool;
}