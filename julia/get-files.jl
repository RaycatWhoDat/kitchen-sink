ignoredPaths = Set([".", "..", ".git", "node_modules"])
indentationWidth = 2
fileLevel = -1

function generateIndent(fileLevel = 0)
    indentation = "";
    let index = 0
        while index < indentationWidth * fileLevel
            indentation *= " "
            index += 1
        end
    end
    return indentation
end

function listFiles(directoryPath = pwd())
    global fileLevel += 1
    for entry in readdir(directoryPath)
        if in(entry, ignoredPaths) continue end
        println(generateIndent(fileLevel) * "$entry")
        if isdir(abspath("$directoryPath/$entry")) cd(listFiles, abspath("$directoryPath/$entry")) end
    end
    global fileLevel -= 1
end

if length(ARGS) > 0
    listFiles(popfirst!(ARGS))
else
    listFiles()
end
