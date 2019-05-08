var generateRandomString = stringLength => {
    if (!stringLength || typeof stringLength !== 'number' || stringLength <= 0) return;

    // 48 - 57 are numbers.
    // 65 - 90 are uppercase letters.
    // 97 - 122 are lowercase.

    const characterClasses = {
        uppercase: [65, 90],
        lowercase: [97, 122]
    };

    const characterClassIndex = Object
        .keys(characterClasses)
        .map(characterClassName => characterClasses[characterClassName]);

    const randomNumbers = Array(stringLength).fill(0).map(() => {
        const characterType = Math.floor(Math.random() * characterClassIndex.length);
        const upperLimit = characterClassIndex[characterType][1];
        const lowerLimit = characterClassIndex[characterType][0];

        const totalRange = upperLimit - lowerLimit;
        return Math.floor(Math.random() * totalRange + lowerLimit);
    });

    return String.fromCharCode.apply(null, randomNumbers);
};

generateRandomString(7);
