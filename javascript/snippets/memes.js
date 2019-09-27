function memeGenerator(input) {
    if (typeof input !== 'string') return;
    const displayString = (startPos) => {
        console.log(input.slice(0, input.length - Math.abs(startPos)));
        if (Math.abs(startPos - 1) < input.length) displayString(startPos - 1);    
    }
    displayString(input.length - 1);
}

memeGenerator('This is a test');
