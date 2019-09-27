function formatPhoneNumber(phoneNumber) {
    const [_phoneNumber, countryCode, areaCode, firstPart, secondPart] = phoneNumber.replace(/\D/, '').match(/(\d{1})?(\d{3})(\d{3})(\d{4})/) || [];
    if (!_phoneNumber) return phoneNumber;
    return countryCode
        ? `+${countryCode} ${areaCode}-${firstPart}-${secondPart}`
        : `${areaCode}-${firstPart}-${secondPart}`;
}

var testCases = [
    '555555555',
    '5555555555',
    '555555555555'
];

console.log(testCases.map(formatPhoneNumber));
