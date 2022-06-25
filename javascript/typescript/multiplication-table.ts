const MAX_NUMBER = 13;
const numbers = [...new Array(MAX_NUMBER)].map((_, index) => index);
const formatString = "%s ".repeat(MAX_NUMBER + 1);
console.log(formatString, ...["", ...numbers].map(item => `${item}`.padStart(3)));

numbers.forEach((number1, index1) => {
  const result = [`${index1}`.padStart(3)];
  numbers.forEach(number2 => result.push(`${number1 * number2}`.padStart(3)));
  console.log(formatString, ...result);
});
