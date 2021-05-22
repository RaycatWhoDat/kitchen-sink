# The Kitchen Sink

![Perilous Forays, the Magic: The Gathering card](https://c1.scryfall.com/file/scryfall-cards/art_crop/front/4/2/4210a148-d16c-42de-b0d6-83c05c553dd4.jpg?1598916443)

> "[*This*](https://github.com/RayMPerry/kitchen-sink) is the place? This map has got to be wrong … ." — Svania Trul, wayfinder novice, last words

> Some people say, "[Programming languages] are just tools. Just learn them as needed." I agree, but I still have a favorite hammer and drill.

## Introduction
As a web dev, a lot of my time is spent working and building the same sort of applications. This repository contains experiments, oddities, and other such scripts that spawned from a foray into a language. (Mostly) comprised of JavaScript, I plan on using this repo to post my findings and learnings from other languages. Ideally, I would like to reduce the number of languages I *have* to know to be gainfully employed and enjoy working with. Realistically, I could stop right now and just use JavaScript but someone might try to gatekeep me because, ya know, "JavaScript is a bad language" and all that.

## Things I Want Out of My Languages
- Good compilation time (prefer not to "keep it running")
- Macros
- ML-caliber pattern matching
- Strong standard library offering
- Very strong understanding of ranges/iterables/enumerables (`zip` should be a method that exists and has variable arity)
- A healthy dose of functional methods
- A good FFI story (if the language is "slow")
- JavaScript transpilation (optional)
- WebAssembly target (optional)

(If a language doesn't fulfill at least two items on this list, it probably does something neat.)

## Languages I'm Aware Of But Never Tried
Haskell, Elm, F#, Java

## Other Languages I've Tried
Julia, OCaml, Awk, Perl, Elixir, Ruby/Crystal, Chez/Gambit/Guile/Chicken Scheme, C/C++, Chapel, V, 8th

With that out of the way, let's get started.

## Top 20 Languages
### 20. [LDPL](https://www.ldpl-lang.org/)
Okay, hear me out. You see this funky little dinosaur here? I love 'im. I'd take a bullet for 'im. 

![Funky Little Dinosaur](https://www.ldpl-lang.org/graphics/other/tutorial-logo.png)

In all seriousness, this is a fun toy language. There are some nice applications that have been written in it but I can't see myself using this as a go-to.

### 19. [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) (TODO)

### 18. [Dart](https://dart.dev/)
Okay, so, Dart. I like this language. It *feels* like a more solid TypeScript where as TypeScript still feels like JavaScript. (I still like both.) It comes from the Google folks so, at any given time, it could be yeeted into the sun. 

```dart
import "dart:io";

final TWO_SPACES = 2;
final IGNORED_PATHS = [".git", "dist", "love", "node_modules", "target", "dub", "_build"];

void getFiles([String directoryPath = ".", int traversalLevel = 0]) {
  var currentDirectory = Directory(directoryPath);
  var indentation = " " * (TWO_SPACES * traversalLevel);
  var fileListing = currentDirectory.listSync();

  fileListing.sort((file1, file2) => file1.path.compareTo(file2.path));

  fileListing.forEach((file) {
    var currentEntry = file.path.split("/").last;
    stdout.writeln("$indentation${currentEntry}");
    if (file is File || IGNORED_PATHS.contains(currentEntry)) return;
    getFiles(file.path, traversalLevel + 1);
  });
}

void main(List<String> arguments) {
  getFiles(arguments.first ?? ".");
}
```

### 17. [Kotlin](https://kotlinlang.org/)
Kotlin is sweet. There are a lot of niceties in here that make me adore the language. Honestly, I wouldn't mind specializing in this language because of how straight-forward it was to write. Having access to the rest of the JVM ecosystem helps, too.

```kotlin
package getfiles;

import java.io.File;
import kotlin.io.*;

const val INDENTATION_LEVEL = 2

val IGNORED_PATHS = listOf("..", ".", ".git", "node_modules", "dist", ".dub");

fun printFiles(traversalLevel: Int, currentDirectory: File) {
    currentDirectory.walk().maxDepth(1).forEach {
        if (IGNORED_PATHS.contains(it.getName())) return@forEach;

        println(" ".repeat(traversalLevel * INDENTATION_LEVEL) + it.getName());
        if (it.isDirectory()) {
            val currentPath = currentDirectory.getCanonicalPath() + "/" + it.getName() + "/."
            printFiles(traversalLevel + 1, File(currentPath))
        }
    }
}

fun main(args: Array<String>) {
   printFiles(0, File(".."))
}

// Local Variables:
// compile-command: "kotlinc getfiles.kt -include-runtime -d getfiles.jar && java -jar getfiles.jar"
// End:
```

### 16. [Janet](https://janet-lang.org/)
Janet is a Lisp made by the person who made Fennel, a Lisp dialect for Lua. The difference betweent the two is that this implements its own VM instead of leveraging Lua's. I like quite a few of the constructs in here but I found it lacking compared to later dialects. Wouldn't mind writing more of it, though. (Also, GitHub: just let them have syntax highlighting. It's been long enough and you can't blame the author for writing the most code for it.)

```clojure
# -*- compile-command: "janet get-files.janet" -*-

(def *two-spaces* 2)
(def *ignored-paths* '(".git" "dist" "_dub" "target" "love" "node_modules"))

(defn member
  "Given ARR is an array-like structure, return TRUE if TARGET is found in the array."
  [arr item]
  (some (partial = item) arr))

(defn get-files
  "Get all the files in DIRECTORY-PATH recursively."
  [&opt directory-path traversal-level]
  (default directory-path ".")
  (default traversal-level 0)

  (each file (sort (os/dir directory-path))
    (print (string (string/repeat " " (* *two-spaces* traversal-level)) file))
    (when (and
            (= (os/stat (string/join @[directory-path file] "/") :mode) :directory)
            (not (member *ignored-paths* file)))
      (get-files (string/join @[directory-path file] "/") (+ traversal-level 1)))))

(defn main [& args]
    (get-files (if (> (length args) 1) (last args) nil)))
```

### 15. [TCL](https://www.tcl-lang.org/)
TCL (pronounced "tickle") is a neat homoiconic language with a pretty cool concurrency model. The story here is that "everything is a string" so, naturally, I had to try it out. I found it to be only slightly more expressive than Lua which is both good and bad. The real killer came from the deployment/portability aspect. Unless you had a go-to Starkit (pre-packaged TCL distribution), you didn't really have a clean way to move your scripts around.

```tcl
#!/bin/sh
# the next line restarts using tclsh \
    exec tclsh "$0" ${1+"$@"}

set indentation_level 2

proc generate_indent { traversal_level } {
    global indentation_level
    set indentation ""
    for {set index 0} {$index < [expr $traversal_level * $indentation_level]} {incr index} {
        append indentation " "
    }
    return $indentation
}

proc list_files { directory traversal_level } {
    set excluded_paths { ".git" "node_modules" "target" }

    if { $directory == "" } { set directory "." }

    foreach file [lsort -increasing [glob -nocomplain -directory $directory *]] {
        set should_be_excluded 0
        foreach path_to_exclude $excluded_paths {
            if { [regexp "$path_to_exclude" "$file"] } {
                set should_be_excluded 1
                break
            }
        }

        if { $should_be_excluded } { break }

        puts "[generate_indent $traversal_level][regsub $directory $file {}]"
        if { [file isdirectory "$file"] } { list_files "$file" [expr $traversal_level + 1] }
    }
}

list_files $argv 0
```

### 14. [Lua](http://www.lua.org/)
Oh, hey, speak of the devil. Lua is the other language people love to hate. Something about 1-indexed arrays (even though arrays aren't really a construct here; we accept tables as valid currency)? The language does what it needs to do and it's super-embeddable. There's a metric tonne of games out there that use Lua for scripting. Writing the example here was a bit more explicit than I'd like but I don't recall hating it.

```lua
local lfs = require('lfs')
local indent_width = 4
local max_file_level = -1
local ignored_paths = { '.', '..', '.git', 'node_modules' };

function is_ignored_path(path_name)
   for _, ignored_path in pairs(ignored_paths) do
      if path_name == ignored_path then return true end
   end
   return false
end

function generate_indent(max_file_level)
   local indent = '';
   for file_level = 0, max_file_level, 1 do
      for width = 1, indent_width, 1 do
         indent = indent .. ' '
      end
   end
   return indent
end

function print_file_name(file_name)
   if is_ignored_path(file_name) then return end
   print(generate_indent(max_file_level) .. file_name)
   assert(lfs.attributes(file_name, 'mode') ~= nil)
   if lfs.attributes(file_name, 'mode') == 'directory' then
      return print_files_recursively(file_name)
   else
      return file_name
   end
end

function print_files_recursively(directory_name)
   max_file_level = max_file_level + 1
   local current_directory = directory_name ~= nil and directory_name or lfs.currentdir()
   lfs.chdir(current_directory)
   for file_name in lfs.dir(lfs.currentdir()) do
      -- print(lfs.currentdir(), file_name)
      print_file_name(file_name)
   end
   lfs.chdir('..')
   max_file_level = max_file_level - 1
   if max_file_level < 0 then
      os.exit()
   end
end

print_files_recursively()
```

### 13. [Common Lisp](https://common-lisp.net/) ([SBCL](http://www.sbcl.org/))
Ah, yes. Common Lisp. I have gone back and forth on this language because it's kinda a jack of all trades. Bitrot is almost non-existent here and there are a lot of battle-tested libraries. Originally, I thought you had to keep the car running here but it seems like you could do something like `sbcl --script get-files.lisp` and get the results you want. I need to revisit this and work with the language with that in mind.  

```lisp
(defun print-files (&optional (relative-directory "..") (traversal-level 0))
  "Prints all the files recursively, starting at RELATIVE-DIRECTORY."
  (declare (optimize (speed 3) (space 3) (safety 0) (debug 0)))
  (let ((ignored-paths '(".git" "love" "target" "dist" ".dub" "node_modules"))
         (current-location (uiop:resolve-location (truename relative-directory))))
    (loop for listing in (append (uiop:directory-files current-location) (uiop:subdirectories current-location))
      do (format t "~A~A~%"
           (make-sequence 'string (* 2 traversal-level) :initial-element #\ )
           (if (string= (file-namestring listing) "")
             (car (last (pathname-directory listing)))
             (file-namestring listing)))
      when (uiop:directory-exists-p listing)
      unless (member (car (last (pathname-directory listing))) ignored-paths :test 'string=)
      do (print-files listing (1+ traversal-level)))))
```

### 12. [Python](https://www.python.org/)
It's Python. Language is good. What else is there to talk about?

```python
from os import scandir

INDENTATION_WIDTH = 2
IGNORED_PATHS = [".git", "node_modules", "target", "dist", ".dub", "love"]

def doFiles(directoryPath = ".", traversalLevel = 0, callback = print):
    for entry in scandir(directoryPath):
        callback(' ' * (INDENTATION_WIDTH * traversalLevel) + entry.name)
        if entry.is_dir() and not entry.name in IGNORED_PATHS:
            doFiles(directoryPath + "/" + entry.name, traversalLevel + 1, callback)

printFiles = lambda directoryPath: doFiles(directoryPath, 0, print)

printFiles('..')

# Local Variables:
# compile-command: "python3 ./get-files.py"
# End:
```

### 11/10. [REBOL](http://www.rebol.com/)/[Red](https://www.red-lang.org/)
Now, we're getting into the nitty-gritty. REBOL and Red are sharing a line because of how similar they are. They're both homoiconic languages that take the block-and-word-based approach to programming, with Red being the most actively-developed language. The concept of "no reserved keywords" is always interesting to me because they're treating the words like a spoken language. The meaning of a word changes based on the context which has interesting effects when interweaving dialects. Can't wait for the cross-platform kinks to get worked out.

```red
Red []

ignored-paths: [".git/" "node_modules/" "target/" "love/" ".dub/" "dist/"]

get-files: function [
  "This takes a directory path."
  current-directory [file! string!] "The directory path."
  file-level [integer!] "The current indentation level."
][
  listing: read to-red-file current-directory
  
  foreach entry listing [
    repeat counter (file-level * 2) [prin " "]
    if (find ignored-paths (make string! entry)) <> none [continue]
    print entry
    if dir? entry [get-files rejoin [current-directory "/" entry] file-level + 1]
  ]
]

get-files either (length? system/options/args) > 0 [last system/options/args][".."] 0

; Local Variables:
; mode: rebol
; compile-command: "./red get-files.red"
; End:
```

### 9. [Racket](https://www.racket-lang.org/)
Oh boy, it's Racket. I like Racket. Very friendly and batteries-included, albeit a touch explicit. I'd almost argue that it's the Python of Schemes. (Yes, I know it's an amalgam of Lisp and Scheme; just roll with it.) Honestly, I think I would choose this language if it had a nice way to handle data munging.

```racket
#!/usr/bin/env racket

#lang racket/base

(require racket/path racket/string)

(define (get-files (directory-path "..") (traversal-level 0))
  (for ((entry (directory-list directory-path)))
    (let ((current-path (path->string entry)))
      (printf (string-append (make-string (* 2 traversal-level) #\space) "~a~%") current-path)
      (unless (for/or ((ignored-path '(".git" "love" "target" "dist" ".dub" "node_modules")))
                (string-contains? current-path ignored-path))
        (when (directory-exists? (path->directory-path (build-path directory-path current-path)))
          (get-files (string-append directory-path "/" current-path) (+ traversal-level 1)))))))

(if (zero? (vector-length (current-command-line-arguments)))
    (get-files)
    (get-files (vector-ref (current-command-line-arguments) 0)))

;; Local Variables:
;; compile-command: "racket ./get-files.rkt"
;; End:
```

### 8. [Nim](https://nim-lang.org/)
Nim, Nim, Nim. I have a few gripes about how UFCS works here and there's no variadic `zip` but overall, this language is sweet. No two ways about it. They even have these source code filters which I think are super cool. 

```nim
import os
from strutils import spaces

const
  TWO_SPACES = 2
  ignoredPaths = [".git", "love", "dist", "target", "_dub", "node_modules"]

proc printFiles(directoryPath: string = ".", traversalLevel: int = 0) =
  for kind, path in walkDir(directoryPath):
    var entry = lastPathPart(path)
    echo(spaces(TWO_SPACES * traversalLevel), entry)
    if dirExists(path) and entry notin ignoredPaths:
      printFiles(path, traversalLevel + 1)

let initialDirectory = if len(commandLineParams()) > 0: paramStr(1) else: "."
printFiles(initialDirectory)
```

### 7. [D](https://dlang.org/)
Ah, D. One of my first loves. This language does something that I have yet to see in any non-Lisp language: it allows you to write high-level, almost-script-like code and tune performance with lower constructs when needed. In my travels, I haven't seen a language do it quite like D. For that reason, this language is high on this list.

```d
#!/usr/bin/env rdmd 

module getfiles;

import std.algorithm: canFind;
import std.file: dirEntries, getcwd, SpanMode;
import std.string: replace, join;
import std.stdio: writeln;
import std.range: repeat;
import std.path: dirSeparator;
import std.getopt;

const string INDENTATION_CHARACTER = " ";
const int TWO_SPACES = 2, FOUR_SPACES = 4;

string[] ignoredPaths = [".git", "node_modules", "target", "love", "dist", ".dub", "build", "_build"];
string directoryPath;
bool isRecursive = false;

void printFiles(string directoryPath, int traversalLevel = 0) {
  foreach (entry; directoryPath.dirEntries(SpanMode.shallow)) {
    string currentEntry = entry.name;
    if (directoryPath != ".") {
      currentEntry = currentEntry.replace(directoryPath, "").replace(dirSeparator, "");
    }
    
    if (ignoredPaths.canFind(currentEntry)) continue;

    INDENTATION_CHARACTER
        .repeat(TWO_SPACES * traversalLevel)
        .join("")
        .writeln(currentEntry);

    if (isRecursive && entry.isDir) entry.name.printFiles(traversalLevel + 1);
  }
}

void main(string[] args) {
  directoryPath = getcwd();

  getopt(args,
         std.getopt.config.passThrough,
         "directory", &directoryPath,
         "recursive", &isRecursive);

  directoryPath.printFiles();
}

// Local Variables:
// compile-command: "./get-files.d"
// End:
```

### 6. [Haxe](https://haxe.org/)
Hello, old friend. Haxe is a... uh... yeah, how do you describe this language? It's a cross-platform, cross-language toolkit that leverages the libraries and platforms of the target programming language. It sounds weird but that's the best way to describe it. 

```haxe
import sys.FileSystem.readDirectory;
import sys.FileSystem.isDirectory;

function printFiles(directoryPath = "..", traversalLevel = 0) {
  var TWO_SPACES = 2;
  var ignoredPaths = [".git", "node_modules", "target", "love", "dist", "build", "_build", ".dub"];

  for (entry in readDirectory(directoryPath)) {
    var spaces = new StringBuf();
    for (index in 0...(traversalLevel * TWO_SPACES)) spaces.add(" ");
    Sys.println(spaces.toString() + entry);
    if (ignoredPaths.indexOf(entry) > -1) continue;
    if (isDirectory(directoryPath + "/" + entry)) {
      printFiles(directoryPath + "/" + entry, traversalLevel + 1);
    }
  }
}

function main() {
  if (Sys.args().length < 1) return;
  GetFiles.printFiles(Sys.args()[0]);
}

// Local Variables:
// compile-command: "haxe GetFilesCpp.hxml"
// End:
```
### 5. [Raku](https://raku.org/)
Okay, we're approaching the top of the top here. I adore Raku. There are so many nice things it gives you. There's a sweet MOP in here, there's lazy lists, sequences, reactive programming... and it goes on and on. The ONLY problems I have with it is that speed is rough and I need a more expressive way to do data munging. If it had that last one solved, this would be a different list.

```raku
my constant $TWO_SPACES = 2;
my @ignoredPaths = <. .. .git .dub node_modules build zef target>;

sub doFiles(IO(Str) $directoryPath, &callback = { .put }, $depth = 0) {
    for $directoryPath.dir.sort({ not .d, .Str }) -> $currentListing {
        next if $currentListing.basename (elem) @ignoredPaths;
        &callback(' ' x ($TWO_SPACES * $depth) ~ $currentListing.basename);
        doFiles($currentListing, &callback, $depth + 1) if $currentListing.d;
    }
}

doFiles("..", { .put });
```

### 4. [Rust](https://www.rust-lang.org/)
*Sigh.* Let's talk about Rust.

I do not like Rust's syntax and I don't like how verbose it can be.

However, if there's one thing I can count on, it's the community behind it. You simply don't count out people's passion to make cool things. As a result of that thinking, Rust is my go-to pick for systems-level programming and WebAssembly compilation. So, I have to suck it up and learn it to get past that possible gatekeeping in the future.

```rust
// (compile "cargo run ..")

use std::env::args;
use std::fs::read_dir;
use std::io::Result;
use std::path::{Path, PathBuf};
use std::string::String;

const TWO_SPACES: usize = 2;

fn get_files(
    directory_path: &PathBuf,
    callback: &dyn Fn(&String, &str) -> (),
    traversal_level: usize,
) -> Result<()> {
    let ignored_paths = ["node_modules", ".git", "target", "dist", "dub", "love"];

    let mut entries = read_dir(directory_path)?
        .map(|entry| entry.unwrap().path())
        .collect::<Vec<_>>();

    entries.sort();

    let indentation = " ".repeat(traversal_level * TWO_SPACES);

    for entry in entries {
        let last_path_component = entry.iter().last().unwrap();
        let formatted_path = last_path_component.to_str().unwrap();

        if ignored_paths.contains(&formatted_path) { continue; }

        callback(&indentation, formatted_path);

        if Path::new(&entry).is_dir() {
            get_files(&entry, callback, traversal_level + 1).ok();
        }
    }

    Ok(())
}

fn main() -> Result<()> {
    let directory_path = PathBuf::from(args().last().unwrap_or(".".to_string()));
    let print_item = |indentation: &String, item: &str| println!("{}{}", indentation, item);

    get_files(&directory_path, &print_item, 0)
}
```

### 3. [TXR](http://nongnu.org/txr/)
On the flip side, let's talk about TXR. This language is very weird because it's really two separate ones mashed together. There's TXR the pattern matching dialect, and TXR Lisp the Lisp dialect. Between these two, they handle almost every problem I have with regards to data munging. So much so, it's my second go-to language.

#### TXR Pattern Matching
```
@(next "MOCK_DATA.csv")
@nil
@(collect)
@first_name,@last_name,@email,@dob
@(end)
@(output)
@(repeat)
First Name: @first_name
Last Name: @last_name
Email: @email
Date of Birth: @dob

@(end)
@(end)
```

#### TXR Lisp
```lisp
(defvar *TWO-SPACES* 2)
(defvar *ignored-paths*
  '("." ".." ".git" ".gitattributes" ".gitignore" ".dub" "node_modules" "build" "target" "zef"))

(defun print-listing (entry indentation-level)
  (pprinl (cat-str (append (repeat '(#\ ) (* *TWO-SPACES* indentation-level)) entry))))

(defun do-files (callback : (directory-path ".") (indentation-level 0))
  (each ((entry (sort (get-lines (open-directory directory-path)))))
    (let ((full-path (path-cat directory-path entry)))
      (unless (member entry *ignored-paths*)
        (eval ^(,callback ,entry ,indentation-level))
        (when (path-dir-p full-path)
          (do-files callback full-path (+ indentation-level 1)))))))

(do-files 'print-listing (or (car *args*) ".."))
```

### 2. [Emacs](https://www.gnu.org/software/emacs/) Lisp
I use Emacs, so Emacs Lisp is a logical tool in the belt here. It's my go-to for making text-based applications that live in Emacs.

```elisp
(defvar *ignored-paths* '("." ".." ".git" "love" "target" "node_modules" "dist" ".dub"))

(defun print-files-with-color (indentation-width traversal-level directory-path file-path)
  "Print FILE-PATH with a color."
  (insert
    (propertize
      (concat (make-string (* indentation-width traversal-level) ?\s) file "\n")
      'font-lock-face
      (if (f-directory-p (concat directory-path "/" file-path))
        'font-lock-keyword-face
        'font-lock-builtin-face))))

(defun find-files-recursively (directory-path &optional found-files)
  "Using DIRECTORY-PATH as a starting point, find all the files in the current and child directories."
  (loop for file in (directory-files directory-path)
    unless (member file *ignored-paths*)
    collect file into found-files
    when (and (f-directory-p (concat directory-path "/" file)) (not (member file *ignored-paths*)))
    do (find-files-recursively (concat directory-path "/" file) found-files)
    finally (return found-files)))

(defun print-files-recursively (directory-path traversal-level)
  (let ((indentation-width 2))
    (dolist (file (directory-files directory-path))
      (unless (member file *ignored-paths*)
        (let ((is-directory (f-directory-p (concat directory-path "/" file))))
          (print-files-with-color indentation-width traversal-level directory-path file)
          (when is-directory
            (print-files-recursively
              (concat directory-path "/" file)
              (1+ traversal-level))))))))

(defun prompt-for-path (current-directory)
  "Prompt for CURRENT-DIRECTORY and list files."
  (interactive "DPath to list out: ")
  (let ((file-listing-buffer-name "*File Listing*"))
    (when (get-buffer file-listing-buffer-name)
      (kill-buffer file-listing-buffer-name))
    (switch-to-buffer-other-window file-listing-buffer-name)
    (print-files-recursively current-directory 0)
    (special-mode)
    (font-lock-mode)))

(find-files-recursively "..")
```

### 1. JavaScript ([MDN](https://developer.mozilla.org/en-US/docs/Web/javascript))
I'm a web dev. Did you think there would be another language up here?

```js

const fs = require('fs');

const IGNORED_PATHS = ['.', '..', '.git', 'love', 'target', 'node_modules', 'dist'];
const INDENTATION_LEVEL = 2;

const doFiles = callback => (directory, fileLevel) => {
    const files = fs.readdirSync(directory || '.', { withFileTypes: true });
    if (!files.length) return;
    let _fileLevel = fileLevel || 0;
    files.forEach(file => {
        if (IGNORED_PATHS.includes(file.name)) return;
        callback(' '.repeat(INDENTATION_LEVEL * _fileLevel) + file.name);
        if (file.isDirectory()) doFiles(callback)(directory + '/' + file.name, _fileLevel + 1);
    });
};

const printFiles = doFiles(console.log);
const rootDirectoryPath = process.argv.slice(2).pop() || '..';

printFiles(rootDirectoryPath);
```
