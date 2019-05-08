var mapping = [
    '01010101',
    '11010010',
    '10101010'
].map(rawData => rawData.split('').map(fragment => Boolean(Number(fragment))));

console.log(mapping);
