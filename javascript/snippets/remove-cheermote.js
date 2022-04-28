'use strict';

const testCase1 = 'hol up let me try this again <span class="cheermote-100"><img src="example.jpg" /></span>';
const testCase2 = '<span class="cheermote-100"><img src="example.jpg" /></span> hol up let me try this again';
const testCase3 = 'another one <span class="cheermote-100"><img src="example.jpg" /></span>   hol up let me try this again <span class="cheermote-100"><img src="example.jpg" /></span>';

const removeHTML = message => message.replace(/<[^>]*>/g, '').replace(/\s{2,}/g, ' ').trim();

[
  testCase1,
  testCase2,
  testCase3
].forEach(message => console.log(removeHTML(message)));
  
