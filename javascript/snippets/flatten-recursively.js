function flattenRecursively(result, array) {
    const items = Array.isArray(array) ? array : [array];
    items.forEach(item => Array.isArray(item) ? flattenRecursively(result, item) : result.push(item));
    return result;
}

Array(10).fill([1, [2, [3]]]).reduce(flattenRecursively, []);
