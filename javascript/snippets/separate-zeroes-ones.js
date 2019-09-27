var testCase1 = Array(10).fill(0).map(value => Math.round(Math.random()));
console.log(testCase1);

var result = testCase1.reduce((_result, item) => {
    if (item === 0) return [item].concat(_result);
    if (item === 1) return _result.concat(item);
    return _result;
}, []);

console.log(result);
