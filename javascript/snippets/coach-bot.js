const tmi = require('tmi.js');
const commands = require('./commands');
const subEvents = require('./subEvents');
const webHooks = require('./webHooks');

const { BOT_USERNAME, OAUTH_TOKEN, CHANNEL_NAME } = process.env;
const BOT_PREFIX = '!';

const eventLogger = (name, callback) => {
    if (!callback || typeof callback !== 'function') return console.warn(`No handler for: ${name}`);
    callback();
}

// Define configuration options
const opts = {
    identity: {
        username: BOT_USERNAME,
        password: OAUTH_TOKEN
    },
    channels: [CHANNEL_NAME]
};

if (process.env.NODE_ENV !== 'production') {
    console.log(`Including .env`);
    require('dotenv').config();
}

const onMessageHandler = (target, context, msg, self) => {
    if (self) return;

    const commandName = msg.trim();
    if (commandName[0] != BOT_PREFIX && commandName[0] != 'o') return;

    console.log(`Parsing message: ${msg}`);
    
    const commandArray = commandName.split(' ');
    const command = commands.getCommand(commandArray[0], context.username);

    if (!command) return console.log(`${commandName}: is borked`);
    command(client, target, context, commandArray.slice(1), coachBot.onMessage);
}

const onConnectedHandler = (addr, port) => console.log(`* Connected to ${addr}:${port}`);

// Create a client with our options
const client = new tmi.client(opts);

// Register our event handlers (defined below)
client.on('message', onMessageHandler);
client.on('connected', onConnectedHandler);

// Connect to Twitch:
client.connect();

const ANON_GIFT_PAID_UPGRADE = 'anongiftpaidupgrade';
const GIFT_PAID_UPGRADE = 'giftpaidupgrade';
const RESUB = 'resub';
const SUB_GIFT = 'subgift';
const SUB_MYSTERY_GIFT = 'submysterygift';
const ANON_SUB_GIFT = 'anonsubgift';
const ANON_SUB_MYSTERY_GIFT = 'anonsubmysterygift';
const PRIME_PAID_UPGRADE = 'primepaidupgrade';
const SUBSCRIPTION = 'subscription';

const coachBot = {
    [ANON_GIFT_PAID_UPGRADE]: () => eventLogger(ANON_GIFT_PAID_UPGRADE),
    [GIFT_PAID_UPGRADE]: () => eventLogger('giftpaidupgrade', subEvents.newSubscriber),
    [RESUB]: () => eventLogger('resub', subEvents.newSubscriber),
    [SUB_GIFT]: () => eventLogger('subgift', subEvents.newSubscriber),
    [SUB_MYSTERY_GIFT]: () => eventLogger('submysterygift', subEvents.newSubscriber),
    [ANON_SUB_GIFT]: () => eventLogger('anonsubgift', subEvents.newSubscriber),
    [ANON_SUB_MYSTERY_GIFT]: () => eventLogger('anonsubmysterygift', subEvents.newSubscriber),
    [PRIME_PAID_UPGRADE]: () => eventLogger('primepaidupgrade', subEvents.newSubscriber),
    [SUBSCRIPTION]: (channel, username, method, message, userstate) => eventLogger('subscription', () => subEvents.newSubscriber(userName, coachBot.onMessage))
};

Object.keys(coachBot).forEach(keyName => client.on(keyName, coachBot[keyName]));

module.exports = coachBot;
