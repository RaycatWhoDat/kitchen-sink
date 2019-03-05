package love.filesystem;

import haxe.extern.Rest;
import lua.Table;
import lua.UserData;

@:native("love.filesystem")
extern class FilesystemModule
{

	public static function append(name:String, data:String, ?size:Float) : FilesystemModuleAppendResult;

	public static function areSymlinksEnabled() : Bool;

	public static function createDirectory(name:String) : Bool;

	public static function exists(filename:String) : Bool;

	public static function getAppdataDirectory() : String;

	public static function getDirectoryItems(dir:String) : Table<Dynamic,Dynamic>;

	public static function getIdentity(name:String) : Void;

	public static function getLastModified(filename:String) : FilesystemModuleGetLastModifiedResult;

	public static function getRealDirectory(filepath:String) : String;

	public static function getRequirePath() : String;

	public static function getSaveDirectory() : String;

	public static function getSize(filename:String) : FilesystemModuleGetSizeResult;

	public static function getSource() : String;

	public static function getSourceBaseDirectory() : String;

	public static function getUserDirectory() : String;

	public static function getWorkingDirectory() : String;

	public static function init(appname:String) : Void;

	public static function isDirectory(path:String) : Bool;

	public static function isFile(path:String) : Bool;

	public static function isFused() : Bool;

	public static function isSymlink(path:String) : Bool;

	public static function lines(name:String) : Dynamic;

	public static function load(name:String, ?errormsg:String) : Dynamic;

	@:overload(function (archive:String, mountpoint:String, ?appendToPath:String) : Bool {})
	public static function mount(archive:String, mountpoint:String) : Bool;

	public static function newFile(filename:String, ?mode:FileMode) : FilesystemModuleNewFileResult;

	@:overload(function (filepath:String) : FilesystemModuleNewFileDataResult {})
	public static function newFileData(contents:String, name:String, ?decoder:FileDecoder) : FileData;

	public static function read(name:String, ?bytes:Float) : FilesystemModuleReadResult;

	public static function remove(name:String) : Bool;

	public static function setIdentity(name:String, ?appendToPath:Bool) : Void;

	public static function setRequirePath(paths:String) : Void;

	public static function setSource(path:String) : Void;

	public static function setSymlinksEnabled(enable:Bool) : Void;

	public static function unmount(archive:String) : Bool;

	public static function write(name:String, data:String, ?size:Float) : Bool;
}

@:multiReturn
extern class FilesystemModuleGetLastModifiedResult
{
	var modtime : Float;
	var errormsg : String;
}

@:multiReturn
extern class FilesystemModuleGetSizeResult
{
	var size : Float;
	var errormsg : String;
}

@:multiReturn
extern class FilesystemModuleNewFileResult
{
	var file : File;
	var errorstr : String;
}

@:multiReturn
extern class FilesystemModuleAppendResult
{
	var success : Bool;
	var errormsg : String;
}

@:multiReturn
extern class FilesystemModuleReadResult
{
	var contents : String;
	var size : Float;
}

@:multiReturn
extern class FilesystemModuleNewFileDataResult
{
	var data : FileData;
	var err : String;
}