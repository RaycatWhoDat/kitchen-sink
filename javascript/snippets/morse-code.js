'use strict';

const key = '-----.....----';

const encode = number => `${number}`.split('').map(digit => key.substring(+digit, +digit + 5)).join('');
const decode = code => Number([...Array(Math.floor(code.length / 5))].map((_, index) => key.indexOf(code.substring(index * 5, (index * 5) + 5))).join(''));

console.log(encode(1203))
console.log(decode("-----.....-----.....-----"))
