indentationWidth = 2;
ignoredPaths = [".", "..", ".git", "node_modules", "target", "love", ".dub", "dist"];

function doFiles(directoryPath = pwd(), traversalLevel = 0, callback = println)
    indentation = ' '^(indentationWidth * traversalLevel)
    for entry in readdir(directoryPath)
        callback(indentation * "$entry")
        fullPath = abspath("$directoryPath/$entry")
        if !isdir(fullPath) || in(entry, ignoredPaths) continue end
        doFiles(fullPath, traversalLevel + 1, callback)
    end
end

length(ARGS) > 0 ? doFiles(popfirst!(ARGS)) : doFiles(pwd())

# Local Variables:
# compile-command: "julia ./get-files.jl .."
# End:
