from os import scandir

INDENTATION_WIDTH = 2
IGNORED_PATHS = [".git", "node_modules", "target", "dist", ".dub", "love"]

def doFiles(directoryPath = ".", traversalLevel = 0, callback = print):
    for entry in scandir(directoryPath):
        callback(' ' * (INDENTATION_WIDTH * traversalLevel) + entry.name)
        if entry.is_dir() and not entry.name in IGNORED_PATHS:
            doFiles(directoryPath + "/" + entry.name, traversalLevel + 1, callback)

doFiles("..")
