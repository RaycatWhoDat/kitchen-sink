import os
import sequtils
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

let initialDirectory = if len(commandLineParams()) > 0: paramStr(1) else: ".."
printFiles(initialDirectory)
