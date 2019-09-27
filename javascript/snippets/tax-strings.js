var taxStrings = [
    'TAXABLE',
    'TAXFREE',
    'TAXDEFERRED'
].map(string => {
   const fragments = string.replace('TAX', 'Tax-').split('-');

   if (fragments.length < 2) return string;
   
   const hyphenedSuffixes = ['DEFERRED', 'FREE']; 
   const shouldHypenate = hyphenedSuffixes.includes(fragments[1]);

   fragments[1] = shouldHypenate
    ? fragments[1][0].toUpperCase() + fragments[1].substring(1).toLowerCase()
    : fragments[1].toLowerCase()

   return fragments.join(shouldHypenate ? '-' : '');
});

console.log(taxStrings);
