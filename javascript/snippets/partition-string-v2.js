function partitionString(numberOfChars, replacementChar, string) {
  const splitString = string.split('');
  for (let index = 0; index < splitString.length; index += (numberOfChars + 1)) {
    splitString.splice(index, 0, index ? replacementChar : '');
  }
  return splitString.join('');
};

console.log(partitionString(3, '/', 'this is a test'));
