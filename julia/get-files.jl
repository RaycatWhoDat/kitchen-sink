indentationWidth = 2;
ignoredPaths = [".", "..", ".git", "node_modules", "target", "love", ".dub", "dist"];

function doFiles(directoryPath = pwd(), traversalLevel = 0, callback = println)
    for entry in readdir(directoryPath)
        callback(' '^(indentationWidth * traversalLevel) * "$entry")
        if isdir(abspath("$directoryPath/$entry")) && !in(entry, ignoredPaths)
            doFiles(abspath("$directoryPath/$entry"), traversalLevel + 1, callback)
        end
    end
end

length(ARGS) > 0 ? doFiles(popfirst!(ARGS)) : doFiles(pwd())

# Local Variables:
# compile-command: "julia ./get-files.jl .."
# End:
