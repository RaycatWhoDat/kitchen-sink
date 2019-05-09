function _succDigits(result, number) {
    if (number <= 0) return result;
    return _succDigits(result + ((number % 10) + 1) * 10 ** (Math.log10(result) + 1 | 0), (number - (number % 10)) / 10);
}

function succDigits(number) {
    return _succDigits(0, number);
}

succDigits(998);
