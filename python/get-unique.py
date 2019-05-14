def getUnique(collection):
    uniqueNumbers = []
    for index, item in enumerate(collection):
        if collection.index(item) != index:
            if item in uniqueNumbers:
                uniqueNumbers.remove(item)
        else:
            uniqueNumbers.append(item)
    return uniqueNumbers

print(getUnique([0, 1, 1, 1, 2, 2]))

