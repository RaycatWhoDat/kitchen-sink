#!/usr/bin/env node

const https = require('https');

const query = process.argv
      .slice(2)
      .map(argument => encodeURIComponent(argument))
      .join('+');

if (!query.length) {
    console.log('No cards found.');
    return;
}

https.get(`https://api.scryfall.com/cards/search?q=${query}`, response => {
    let data = '';
    
    response.on('data', chunk => data += chunk);
    response.on('end', _ => {
        const results = JSON.parse(data).data || [];

        if (!results.length) console.log('No cards found.');
        
        results.forEach(card => {
            const { name, mana_cost, type_line, oracle_text, power, toughness } = card;
            
            console.log('%s %s', name, mana_cost);
            console.log(type_line);
            console.log(oracle_text);
            if (power != null || toughness != null) console.log('%s/%s', power, toughness);
            console.log('\n');
        });
    });
}).on("error", error => {
    console.error(error);
});
