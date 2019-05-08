function forEach (collection, iterator) {
  Array.isArray(collection) 
    ? collection.forEach(iterator)
    : Object.keys(collection).forEach(iterator);
} 

function findDeep(collection, propertyKey) {
    const results = [];
    if (collection.hasOwnProperty(propertyKey) || collection[propertyKey]) return [collection];

    console.log('> ', collection);

    forEach(collection, function recurAndAssign(datum) {
        if (typeof datum === 'object' && (datum = findDeep(datum, propertyKey)).length) results.push.apply(results, datum);
    });

    return results;
}

findDeep({ a: { b: 1234 } }, 'b');
