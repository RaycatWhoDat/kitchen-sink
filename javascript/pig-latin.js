const pigIt = sentence => {
  if (typeof sentence !== 'string') return sentence;
  return sentence
    .split(' ')
    .map(word => {
       let baseWord = word.substring(1) + word[0];
       return baseWord + (/^[a-zA-Z]+$/.test(word) ? 'ay' : '');
    })
    .join(' ');
};
