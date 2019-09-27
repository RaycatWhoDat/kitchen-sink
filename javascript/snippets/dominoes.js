var testCase1 = "1-1,3-5,5-2,2-3,2-4";
var testCase2 = "4-3,5-1,2-2,1-3,4-4";

function longestMatches(sString) {
    const validMatches = [
    '1,1',
    '2,2',
    '3,3',
    '4,4',
    '5,5',
    '6,6'
    ];
    const tiles = sString.split('-').filter(elem => elem.includes(','));
    const mostMatches = [0];

    tiles.forEach(tile => {
        validMatches.includes(tile)
        ? mostMatches[mostMatches.length - 1]++
        : mostMatches.push(0);
    });

    return Math.max.apply(null, mostMatches) + 1;
}

console.log(longestMatches("1-1")) // 1
console.log(longestMatches("1-2,1-2")) // 1
console.log(longestMatches("3-2,2-1,1-4,4-4,5-4,4-2,2-1")) // 4
console.log(longestMatches("5-5,5-5,4-4,5-5,5-5,5-5,5-5,5-5,5-5,5-5")) // 7
console.log(longestMatches("1-1,3-5,5-5,5-4,4-2,1-3")) // 4
console.log(longestMatches("1-2,2-2,3-3,3-4,4-5,1-1,1-2")) // 3
