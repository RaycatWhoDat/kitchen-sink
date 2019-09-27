function partitionString(separator, chunkSize, input) {
    if (typeof input !== 'string') return input;
    return input
        .split('')
        .reduce((allParts, character, index, inputArray) => {
            if (!index || index % chunkSize) {
                allParts[allParts.length - 1].push(character);
            } else {
                allParts[allParts.length - 1] = allParts[allParts.length - 1].join('');
                allParts[allParts.length] = [character];
            }
            
            if (index + 1 === inputArray.length) {
                allParts[allParts.length - 1] = allParts[allParts.length - 1].join('');
            }

            return allParts;
        },[[]])
        .join(separator)
        .replace(',', '');
}

console.log(partitionString('/', 3, 'this is a test'));
