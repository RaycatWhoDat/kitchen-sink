# kitchen-sink
Everything except. Mostly comprised of Lua, JavaScript, Haxe, Common Lisp, and Rust.

### get-files.{lua}
**Lua**: requires `luafilesystem` to run.

Lists files and directories, recursively, starting at the current directory.

### get-set.{ts,js)
**TypeScript**: requires `typescript` installed globally, `@types/node` installed locally to build.

Traverses a given object and will return the value of the property. If the value is `undefined` while a default value is present, it will return the default value instead of `undefined`. If the set function is called, it will also set the property to the given value.
