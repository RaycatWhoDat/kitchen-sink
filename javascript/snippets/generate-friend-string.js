var generateFriendString = stringLength => {
    if (!stringLength || stringLength <= 0) return;

    // Numbers = 0, uppercase = 1, lowercase = 2
    const lowerRange = [48, 65, 97];
    const upperRange = [57, 90, 122];

    const randomNumbers = [];

    for (let i = 0; i < stringLength; i++) {
        const type = 2; //Math.floor(Math.random() * 3);
        const totalRange = upperRange[type] - lowerRange[type];
        const symbol = Math.floor(Math.random() * totalRange + lowerRange[type]);

        randomNumbers.push(symbol);
    }

    return String.fromCharCode(...randomNumbers);
};

var friendPrefix = 'fren';
var friendSuffix = 's';
var friendBody = generateFriendString(Math.floor(Math.random() * 20));

friendPrefix.concat(friendBody, friendSuffix);
