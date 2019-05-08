var createContractValidator = contract => parsedObject => {
    if (!contract) return false;

    const currentContract = Array.isArray(contract) ? contract : [contract];
    const currentTarget = Array.isArray(parsedObject) ? parsedObject : [parsedObject];

    const allContractTypes = {};
    const allContractKeys = Array.from(new Set(currentContract.reduce((_allContractKeys, contractItem) => {
        const itemKeys = Object.keys(contractItem);
        Array.prototype.push.apply(_allContractKeys, itemKeys);
        itemKeys.forEach(keyName => allContractTypes[keyName] = contractItem[keyName]);
        return _allContractKeys;
    }, [])));

    return currentTarget.every(currentItem => {
        return allContractKeys.every(keyName => {
            if (keyName.endsWith('?')) return true;
            const _keyName = keyName.replace('?', '');
            return currentItem.hasOwnProperty(_keyName) && (typeof currentItem[_keyName] === allContractTypes[_keyName] || currentItem[_keyName] === null);
        });
    });
};

var isValid = createContractValidator([{"ModelId": "string", "oranjAccountId": "string", "twId": "string"}]);
isValid([{ModelId: "a", oranjAccountId: "a", twId: "a"}]);
