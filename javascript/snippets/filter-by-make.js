var testCase = { foo: { values: '1', make: 'Ford' },
  bar: { values: '2', make: 'VW' },
  qux: { values: '3', make: 'Porsche' },
  roo: { values: '4', make: 'Ford' } };

var filtered = Object.keys(testCase).reduce((newObj, keyName) => {
    if (testCase[keyName].make === 'Ford') newObj[keyName] = { ...testCase[keyName] };
    return newObj;
}, {});

console.log(filtered);
