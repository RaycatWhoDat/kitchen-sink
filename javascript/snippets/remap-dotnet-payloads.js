const mockResponse = {
    "Accounts": true,
    "Users": {
        user1: [1, 2, 3],
        user2: [2, 3, 4]
    },
    "MSTR": [3, 4, 5]
};

const rawResponse = mockResponse;
const transformedResponse = {};

Object.keys(rawResponse).forEach(propName => {
    const remappedName = propName[0].toLowerCase() + propName.substr(1);
    transformedResponse[remappedName] = rawResponse[propName];
});

console.log(transformedResponse);
