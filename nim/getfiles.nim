import os

for file in walkDirRec(".."):
    var entry = lastPathPart(file)
    echo(entry)