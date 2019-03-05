package love.graphics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class SpriteBatch extends Drawable
{

	@:overload(function (quad:Quad, x:Float, y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Float {})
	public function add(x:Float, y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Float;

	public function attachAttribute(name:String, mesh:Mesh) : Void;

	public function clear() : Void;

	public function flush() : Void;

	public function getBufferSize() : Float;

	public function getColor() : SpriteBatchGetColorResult;

	public function getCount() : Float;

	public function getTexture() : Texture;

	@:overload(function (id:Float, quad:Quad, x:Float, y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void {})
	public function set(id:Float, x:Float, y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void;

	public function setBufferSize(size:Float) : Void;

	@:overload(function () : Void {})
	public function setColor(r:Float, g:Float, b:Float, ?a:Float) : Void;

	public function setTexture(texture:Texture) : Void;
}

@:multiReturn
extern class SpriteBatchGetColorResult
{
	var r : Float;
	var g : Float;
	var b : Float;
	var a : Float;
}