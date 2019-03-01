package love.graphics;
import love.Data;
import love.Drawable;
import love.filesystem.File;
import love.filesystem.FileData;
import love.image.CompressedImageData;
import love.image.ImageData;
import love.video.VideoStream;
import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.graphics")
extern class GraphicsModule
{

	@:overload(function (drawmode:DrawMode, arctype:ArcType, x:Float, y:Float, radius:Float, angle1:Float, angle2:Float, ?segments:Float) : Void {})
	public static function arc(drawmode:DrawMode, x:Float, y:Float, radius:Float, angle1:Float, angle2:Float, ?segments:Float) : Void;

	@:overload(function (mode:DrawMode, x:Float, y:Float, radius:Float, segments:Float) : Void {})
	public static function circle(mode:DrawMode, x:Float, y:Float, radius:Float) : Void;

	@:overload(function (r:Float, g:Float, b:Float, ?a:Float) : Void {})
	@:overload(function (color:Table<Dynamic,Dynamic>, args:Rest<Table<Dynamic,Dynamic>>) : Void {})
	public static function clear() : Void;

	@:overload(function (discardcolors:Table<Dynamic,Dynamic>, ?discardstencil:Bool) : Void {})
	public static function discard(?discardcolor:Bool, ?discardstencil:Bool) : Void;

	@:overload(function (texture:Texture, quad:Quad, ?x:Float, ?y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void {})
	public static function draw(drawable:Drawable, ?x:Float, ?y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void;

	@:overload(function (mode:DrawMode, x:Float, y:Float, radiusx:Float, radiusy:Float, segments:Float) : Void {})
	public static function ellipse(mode:DrawMode, x:Float, y:Float, radiusx:Float, radiusy:Float) : Void;

	public static function getBackgroundColor() : GraphicsModuleGetBackgroundColorResult;

	public static function getBlendMode() : GraphicsModuleGetBlendModeResult;

	public static function getCanvas() : Canvas;

	public static function getCanvasFormats() : Table<Dynamic,Dynamic>;

	public static function getColor() : GraphicsModuleGetColorResult;

	public static function getColorMask() : GraphicsModuleGetColorMaskResult;

	public static function getCompressedImageFormats() : Table<Dynamic,Dynamic>;

	public static function getDefaultFilter() : GraphicsModuleGetDefaultFilterResult;

	public static function getDimensions() : GraphicsModuleGetDimensionsResult;

	public static function getFont() : Font;

	public static function getHeight() : Float;

	public static function getLineJoin() : LineJoin;

	public static function getLineStyle() : LineStyle;

	public static function getLineWidth() : Float;

	public static function getShader() : Shader;

	public static function getStats() : GraphicsModuleGetStatsResult;

	public static function getStencilTest() : GraphicsModuleGetStencilTestResult;

	public static function getSupported() : Table<Dynamic,Dynamic>;

	public static function getSystemLimits() : Table<Dynamic,Dynamic>;

	public static function getPointSize() : Float;

	public static function getRendererInfo() : GraphicsModuleGetRendererInfoResult;

	public static function getScissor() : GraphicsModuleGetScissorResult;

	public static function getWidth() : Float;

	@:overload(function () : Void {})
	public static function intersectScissor(x:Float, y:Float, width:Float, height:Float) : Void;

	public static function isGammaCorrect() : Bool;

	public static function isWireframe() : Bool;

	@:overload(function (points:Table<Dynamic,Dynamic>) : Void {})
	public static function line(x1:Float, y1:Float, x2:Float, y2:Float, args:Rest<Float>) : Void;

	public static function newCanvas(?width:Float, ?height:Float, ?format:CanvasFormat, ?msaa:Float) : Canvas;

	@:overload(function (file:File, ?size:Float) : Font {})
	@:overload(function (filedata:FileData, ?size:Float) : Font {})
	@:overload(function (?size:Float) : Font {})
	public static function newFont(filename:String, ?size:Float) : Font;

	@:overload(function (vertexcount:Float, ?mode:MeshDrawMode, ?usage:SpriteBatchUsage) : Mesh {})
	@:overload(function (vertexformat:Table<Dynamic,Dynamic>, vertices:Table<Dynamic,Dynamic>, ?mode:MeshDrawMode, ?usage:SpriteBatchUsage) : Mesh {})
	@:overload(function (vertexformat:Table<Dynamic,Dynamic>, vertexcount:Float, ?mode:MeshDrawMode, ?usage:SpriteBatchUsage) : Mesh {})
	public static function newMesh(vertices:Table<Dynamic,Dynamic>, ?mode:MeshDrawMode, ?usage:SpriteBatchUsage) : Mesh;

	@:overload(function (imageData:ImageData) : Image {})
	@:overload(function (compressedImageData:CompressedImageData) : Image {})
	@:overload(function (filename:String, flags:Table<Dynamic,Dynamic>) : Image {})
	public static function newImage(filename:String) : Image;

	@:overload(function (imageData:ImageData, glyphs:String) : Font {})
	@:overload(function (filename:String, glyphs:String, ?extraspacing:Float) : Font {})
	public static function newImageFont(filename:String, glyphs:String) : Font;

	public static function newParticleSystem(texture:Texture, buffer:Float) : ParticleSystem;

	@:overload(function (pixelcode:String, vertexcode:String) : Shader {})
	public static function newShader(code:String) : Shader;

	public static function newText(font:Font, ?textstring:String) : Text;

	public static function newQuad(x:Float, y:Float, width:Float, height:Float, sw:Float, sh:Float) : Quad;

	public static function newScreenshot(?copyAlpha:Bool) : ImageData;

	public static function newSpriteBatch(texture:Texture, ?maxsprites:Float, ?usage:SpriteBatchUsage) : SpriteBatch;

	@:overload(function (videostream:VideoStream, ?loadaudio:Bool) : Video {})
	public static function newVideo(filename:String, ?loadaudio:Bool) : Video;

	public static function origin() : Void;

	@:overload(function (points:Table<Dynamic,Dynamic>) : Void {})
	@:overload(function (points:Table<Dynamic,Dynamic>) : Void {})
	public static function points(x:Float, y:Float, args:Rest<Float>) : Void;

	@:overload(function (mode:DrawMode, vertices:Table<Dynamic,Dynamic>) : Void {})
	public static function polygon(mode:DrawMode, args:Rest<Float>) : Void;

	public static function pop() : Void;

	public static function present() : Void;

	@:overload(function (coloredtext:Table<Dynamic,Dynamic>, x:Float, y:Float, ?angle:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void {})
	public static function print(text:String, x:Float, y:Float, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void;

	@:overload(function (coloredtext:Table<Dynamic,Dynamic>, x:Float, y:Float, wraplimit:Float, align:AlignMode, ?angle:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void {})
	public static function printf(text:String, x:Float, y:Float, limit:Float, ?align:AlignMode, ?r:Float, ?sx:Float, ?sy:Float, ?ox:Float, ?oy:Float, ?kx:Float, ?ky:Float) : Void;

	public static function push(?stack:StackType) : Void;

	@:overload(function (mode:DrawMode, x:Float, y:Float, width:Float, height:Float, rx:Float, ?ry:Float, ?segments:Float) : Void {})
	public static function rectangle(mode:DrawMode, x:Float, y:Float, width:Float, height:Float) : Void;

	public static function reset() : Void;

	public static function rotate(angle:Float) : Void;

	public static function scale(sx:Float, ?sy:Float) : Void;

	@:overload(function (rgba:Table<Dynamic,Dynamic>) : Void {})
	public static function setBackgroundColor(r:Float, g:Float, b:Float, ?a:Float) : Void;

	@:overload(function (mode:BlendMode, ?alphamode:BlendAlphaMode) : Void {})
	public static function setBlendMode(mode:BlendMode) : Void;

	@:overload(function () : Void {})
	@:overload(function (canvas1:Canvas, canvas2:Canvas, args:Rest<Canvas>) : Void {})
	public static function setCanvas(canvas:Canvas, args:Rest<Canvas>) : Void;

	@:overload(function (rgba:Table<Dynamic,Dynamic>) : Void {})
	public static function setColor(red:Float, green:Float, blue:Float, alpha:Float) : Void;

	@:overload(function () : Void {})
	public static function setColorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool) : Void;

	public static function setDefaultFilter(min:FilterMode, ?mag:FilterMode, ?anisotropy:Float) : Void;

	public static function setFont(font:Font) : Void;

	public static function setLineJoin(join:LineJoin) : Void;

	public static function setLineStyle(style:LineStyle) : Void;

	public static function setLineWidth(width:Float) : Void;

	@:overload(function (file:File, ?size:Float) : Font {})
	@:overload(function (data:Data, ?size:Float) : Font {})
	public static function setNewFont(filename:String, ?size:Float) : Font;

	@:overload(function (shader:Shader) : Void {})
	public static function setShader() : Void;

	public static function setPointSize(size:Float) : Void;

	@:overload(function () : Void {})
	public static function setScissor(x:Float, y:Float, width:Float, height:Float) : Void;

	@:overload(function () : Void {})
	public static function setStencilTest(comparemode:CompareMode, comparevalue:Float) : Void;

	public static function setWireframe(enable:Bool) : Void;

	public static function shear(kx:Float, ky:Float) : Void;

	public static function stencil(stencilfunction:Dynamic, ?action:StencilAction, ?value:Float, ?keepvalues:Bool) : Void;

	public static function translate(dx:Float, dy:Float) : Void;
}

@:multiReturn
extern class GraphicsModuleGetColorMaskResult
{
	var r : Bool;
	var g : Bool;
	var b : Bool;
	var a : Bool;
}

@:multiReturn
extern class GraphicsModuleGetDefaultFilterResult
{
	var min : FilterMode;
	var mag : FilterMode;
	var anisotropy : Float;
}

@:multiReturn
extern class GraphicsModuleGetRendererInfoResult
{
	var name : String;
	var version : String;
	var vendor : String;
	var device : String;
}

@:multiReturn
extern class GraphicsModuleGetScissorResult
{
	var x : Float;
	var y : Float;
	var width : Float;
	var height : Float;
}

@:multiReturn
extern class GraphicsModuleGetStatsResult
{
	var drawcalls : Float;
	var canvasswitches : Float;
	var texturememory : Float;
	var images : Float;
	var canvases : Float;
	var fonts : Float;
	var shaderswitches : Float;
}

@:multiReturn
extern class GraphicsModuleGetStencilTestResult
{
	var enabled : Bool;
	var inverted : Bool;
}

@:multiReturn
extern class GraphicsModuleGetDimensionsResult
{
	var width : Float;
	var height : Float;
}

@:multiReturn
extern class GraphicsModuleGetBackgroundColorResult
{
	var r : Float;
	var g : Float;
	var b : Float;
	var a : Float;
}

@:multiReturn
extern class GraphicsModuleGetBlendModeResult
{
	var mode : BlendMode;
	var alphamode : BlendAlphaMode;
}

@:multiReturn
extern class GraphicsModuleGetColorResult
{
	var r : Float;
	var g : Float;
	var b : Float;
	var a : Float;
}