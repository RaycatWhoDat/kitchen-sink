const fs = require('fs');

const IGNORED_PATHS = ['.', '..', '.git', 'love', 'target', 'node_modules'];
const INDENTATION_LEVEL = 2;

const doFiles = callback => (directory, fileLevel) => {
    const files = fs.readdirSync(directory || '.', { withFileTypes: true });
    if (!files.length) return;
    let _fileLevel = fileLevel || 0;
    files.forEach(file => {
        if (IGNORED_PATHS.includes(file.name)) return;
        callback(' '.repeat(INDENTATION_LEVEL * _fileLevel) + '/' + file.name);
        if (file.isDirectory()) doFiles(callback)(directory + '/' + file.name, _fileLevel + 1);
    });
};

const printFiles = doFiles(console.log);

printFiles('..');
