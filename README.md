# kitchen-sink
Everything except. Mostly comprised of Lua, JavaScript, Haxe, Common Lisp, and Rust.

### get-files.lua
**Lua**: requires `luafilesystem` to run.

> Lists files and directories, recursively, starting at the current directory.

### get-set.{ts,js)
**TypeScript**: requires `typescript` installed globally, `@types/node` installed locally to build.

> Traverses a given object and will return the value of the property. If the value is `undefined` while a default value is present, it will return the default value instead of `undefined`. If the set function is called, it will also set the property to the given value.

### hdmi-widget.tcl
**Tcl**: requires `wish` or an equivalent to run.

> Checks `xrandr` for HDMI inputs. If they exist, it will present options to mirror or extend the current display in a direction.

### jrn.lisp
**Common Lisp**: requires `sbcl` or an equivalent to run.

> Waits for user input and appends the text as an entry to a journal file.

### numberPrinter.hx
**Haxe**: requires `haxe`, `neko` to build and run.

> When run with the `--max` flag set to an safe positive integer, it will create a comprehension between 0 and `--max`, iterate over that comprehension, and print each number.

### pipeline-operator.ml
**OCaml**: requires `ocaml` to build and run.

> Runs a set of operations on an array comprehension of 0 and 30.
