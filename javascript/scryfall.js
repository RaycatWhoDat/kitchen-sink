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

    const printCard = ({ name, mana_cost, type_line, oracle_text, power, toughness }, otherCardFace) => {
        console.log('%s %s', name, mana_cost || '');
        if (otherCardFace) console.log('(This card transforms into %s.)', otherCardFace.name);
        console.log(type_line);
        console.log(oracle_text);
        if (power != null || toughness != null) console.log('%s/%s', power, toughness);
        console.log('\n');
    };
    
    response.on('data', chunk => data += chunk);
    response.on('end', _ => {
        const results = JSON.parse(data).data || [];

        if (!results.length) console.log('No cards found.');
        
        results.forEach(card => {
            const currentCardFaces = card.card_faces || [];
            
            currentCardFaces.forEach((cardFace, index, cardFaces) => {
                const otherCardFace = cardFaces[Number(index === 0)];
                printCard(cardFace, otherCardFace);
            });

            if (!currentCardFaces.length) printCard(card);
        });
    });
}).on("error", error => {
    console.error(error);
});
