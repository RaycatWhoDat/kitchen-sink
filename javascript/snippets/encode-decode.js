'use strict'

const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
const key = 'XZNLWEBGJHQDYVTKFUOMPCIASRxznlwebgjhqdyvtkfuompciasr';

const translate = (message, source, destination) => [...message].map(character => {
  const index = source.indexOf(character);
  if (index < 0) return character;
  return destination[index];
}).join('');

rl.question('Enter your secret message: ', secretMessage => {
  rl.close();
  const encryptedMessage = translate(secretMessage, alphabet, key);
  const decryptedMessage = translate(encryptedMessage, key, alphabet);
  console.log(`Encrypted message: ${encryptedMessage}`);
  console.log(`Decrypted message: ${decryptedMessage}`);
});

