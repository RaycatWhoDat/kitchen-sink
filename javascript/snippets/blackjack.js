'use strict';

const makeCard = (number, suit) => {
  let value = 0;

  if (['2','3','4','5','6','7','8','9'].includes(number)) value = [Number(number)];
  if (['10', 'J', 'Q', 'K'].includes(number)) value = [10];
  if (number == 'A') value = [1, 11];
  
  return { display: `${number}${suit}`, value };
};

const numbers = ['2','3','4','5','6','7','8','9','10','J','Q','K','A'];
const suits = ['♥','♠','♦','♣'];

const makeNewDeck = () => {
  const cards = suits.flatMap(suit => numbers.map(number => makeCard(number, suit)));

  return {
    draw: numberOfCards => {
      const indexes = Array.from(new Array(numberOfCards), _ => Math.floor(Math.random() * cards.length));
      return indexes.map(index => cards[index])
    }
  };
};

const makeHand = (cards = []) => {
  const newHand = {
    cards,
    total: 0,
    calculate: () => {
      this.total = (this.cards || []).reduce((_sum, value) => _sum + value, 0);
      return this.total;
    }
  };

  newHand.calculate();
  return newHand;
};

const newGame = () => {
  const deck = makeNewDeck();

  const playerHand = makeHand(deck.draw(2));
  const dealerHand = makeHand(deck.draw(2));

  console.table(playerHand.cards);
  console.table(dealerHand.cards);
};


newGame();
