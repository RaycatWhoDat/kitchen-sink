'use strict';

const fs = require('fs');
const http = require('http');
const path = require('path');

const PORT = process.env.PORT || 8000;

const shuffleButtons = () => {
  const sortedButtons = [
    { text: '0', value: 'zero' },
    { text: '1', value: 'one' },
    { text: '2', value: 'two' },
    { text: '3', value: 'three' },
    { text: '4', value: 'four' },
    { text: '5', value: 'five' },
    { text: '6', value: 'six' },
    { text: '7', value: 'seven' },
    { text: '8', value: 'eight' },
    { text: '9', value: 'nine' },
    { text: '+', value: 'plus' },
    { text: '-', value: 'minus' },
    { text: '*', value: 'multiply' },
    { text: '/', value: 'divide' },
    { text: '=', value: 'equals' },
    { text: 'C', value: 'clear' }
  ];

  sortedButtons.sort(() => (Math.random() > 0.5 ? 1 : -1));
  
  return sortedButtons;
};

const getButtonsRoute = (req, res) => {
  const buttons = shuffleButtons();
  res.writeHead(200, { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' })
  res.end(JSON.stringify({ buttons }))
};

const notFoundRoute = (req, res) => {
  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(
    JSON.stringify({
      message: 'Route not found.',
    })
  );
};

const routes = {
  'GET': {
    '/': getButtonsRoute
  }
};

const server = http.createServer((req, res) => {
  const route = (routes[req.method] || {})[req.url] || notFoundRoute;
  return route(req, res);
});

server.listen(PORT, () => console.log(`Server running on port ${PORT}.`));
