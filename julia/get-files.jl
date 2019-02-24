ignoredPaths = Set([".", "..", ".git", "node_modules", "target"])
indentationWidth = 2;

function generateIndent(traversalLevel = 0)
    indentation = "";
    for index in 0:(indentationWidth * traversalLevel) indentation *= " " end
    return indentation
end

function listFiles(directoryPath, traversalLevel = 0)
    for entry in readdir(directoryPath)
        if in(entry, ignoredPaths) continue end
        println(generateIndent(traversalLevel) * "$entry")
        if isdir(abspath("$directoryPath/$entry"))
            cd(abspath("$directoryPath/$entry"))
            listFiles(pwd(), traversalLevel + 1)
        end
    end
    cd(abspath("$directoryPath"))
end

length(ARGS) > 0 ? listFiles(popfirst!(ARGS)) : listFiles(pwd())
