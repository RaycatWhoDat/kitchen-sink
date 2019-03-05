package love.graphics;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

extern class Mesh extends Drawable
{

	public function attachAttribute(name:String, mesh:Mesh) : Void;

	public function getDrawMode() : MeshDrawMode;

	public function getDrawRange() : MeshGetDrawRangeResult;

	public function getTexture() : Texture;

	@:overload(function (index:Float) : MeshGetVertexResult {})
	public function getVertex(index:Float) : MeshGetVertexResult;

	public function getVertexAttribute(vertexindex:Float, attributeindex:Float) : MeshGetVertexAttributeResult;

	public function getVertexCount() : Float;

	public function getVertexFormat() : Table<Dynamic,Dynamic>;

	public function getVertexMap() : Table<Dynamic,Dynamic>;

	public function isAttributeEnabled(name:String) : Bool;

	public function setAttributeEnabled(name:String, enable:Bool) : Void;

	public function setDrawMode(mode:MeshDrawMode) : Void;

	@:overload(function () : Void {})
	public function setDrawRange(min:Float, max:Float) : Void;

	@:overload(function (texture:Texture) : Void {})
	public function setTexture() : Void;

	@:overload(function (index:Float, vertex:Table<Dynamic,Dynamic>) : Void {})
	@:overload(function (index:Float, x:Float, y:Float, u:Float, v:Float, ?r:Float, ?g:Float, ?b:Float, ?a:Float) : Void {})
	@:overload(function (index:Float, vertex:Table<Dynamic,Dynamic>) : Void {})
	public function setVertex(index:Float, attributecomponent:Float, args:Rest<Float>) : Void;

	public function setVertexAttribute(vertexindex:Float, attributeindex:Float, value1:Float, value2:Float, args:Rest<Float>) : Void;

	public function setVertexColors(on:Bool) : Void;

	@:overload(function (vi1:Float, vi2:Float, vi3:Float) : Void {})
	public function setVertexMap(map:Table<Dynamic,Dynamic>) : Void;

	@:overload(function (vertices:Table<Dynamic,Dynamic>) : Void {})
	public function setVertices(vertices:Table<Dynamic,Dynamic>) : Void;
}

@:multiReturn
extern class MeshGetVertexAttributeResult
{
	var value1 : Float;
	var value2 : Float;
}

@:multiReturn
extern class MeshGetVertexResult
{
	var x : Float;
	var y : Float;
	var u : Float;
	var v : Float;
	var r : Float;
	var g : Float;
	var b : Float;
	var a : Float;
}

@:multiReturn
extern class MeshGetDrawRangeResult
{
	var min : Float;
	var max : Float;
}