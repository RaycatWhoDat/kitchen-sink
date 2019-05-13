// Hmm. I don't think this works...

function findElement(collection, primitive) {
    if (!collection || !Array.isArray(collection)) return;

    var resultingIndex = 0;
    var currentIndex = Math.trunc(collection.length / 2);
    while (collection.length && currentIndex + 1 <= collection.length) {
        if (collection[currentIndex] === primitive) {
            resultingIndex = currentIndex;
            break;
        }
    }

    return resultingIndex;
}
