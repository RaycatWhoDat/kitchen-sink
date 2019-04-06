const fs = require('fs');

const ignored_paths = ['.', '..', '.git', 'love', 'target', 'node_modules'];
const INDENTATION_LEVEL = 2;

const doFiles = callback => (directory, _fileLevel) => {
    const files = fs.readdirSync(directory || '.', { withFileTypes: true });
    if (!files.length) return;
    let fileLevel = _fileLevel || 0;
    files.forEach(file => {
        if (ignored_paths.includes(file.name)) return;
        callback(' '.repeat(INDENTATION_LEVEL * fileLevel) + '/' + file.name);
        if (file.isDirectory()) doFiles(callback)(directory + '/' + file.name, fileLevel + 1);
    });
};

doFiles(console.log)('..');
