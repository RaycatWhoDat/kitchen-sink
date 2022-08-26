func removeGeese(_ birds: inout [String]) -> [String] {
    let geese = ["African", "Roman Tufted", "Toulouse", "Pilgrim", "Steinbacher"]
    birds.removeAll(where: { geese.contains($0) })
    return birds
}

enum WrongResultError: Error {
    case wrongResult
}

var birds = ["Mallard", "Hook Bill", "African", "Crested", "Pilgrim", "Toulouse", "Blue Swedish"]
if (!removeGeese(&birds).elementsEqual(["Mallard", "Hook Bill", "Crested", "Blue Swedish"])) {
    throw WrongResultError.wrongResult
}
